import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network folder/api_services.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var rememberMe = false.obs;
  var emailError = ''.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  Dio dio = Dio();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    if (box.read('rememberMe') ?? false) {
      email.value = box.read('email') ?? '';
      password.value = box.read('password') ?? '';
      rememberMe.value = true;
    }
  }

  Future<void> saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
    if (value) {
      await prefs.setString('savedEmail', email.value);
      await prefs.setString('savedPassword', password.value);
    } else {
      await prefs.remove('savedEmail');
      await prefs.remove('savedPassword');
    }
  }

  Future<bool?> loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe');
  }

  void prefillEmailAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email.value = prefs.getString('savedEmail') ?? '';
    password.value = prefs.getString('savedPassword') ?? '';
  }

  // login method in use
  Future<void> loginFunction() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty.');
      return;
    }

    isLoading(true);
    try {
      var response = await ApiService().post(
        'https://vetkonect.com/backend/public/api/web/v2/login',
        {"email": email.value, "password": password.value},
        Client(),
        "",
      );

      debugPrint('Raw Response Body: ${response.body}');

      var parsedResponse;
      try {
        parsedResponse = jsonDecode(response.body);
      } catch (e) {
        debugPrint('JSON Parsing Error: $e');
        Get.snackbar('Error', 'Invalid server response format.');
        return;
      }

      debugPrint('Parsed Response: $parsedResponse');

      if (response.statusCode == 200 &&
          parsedResponse is Map<String, dynamic>) {
        if (parsedResponse.containsKey('email')) {
          Get.snackbar('Success', 'Login Successful');
          Get.offAllNamed('/dashboard');
        } else {
          // Handle server error responses or failed login attempts
          String errorMessage = parsedResponse['message'] ??
              parsedResponse['detail'] ??
              'Login failed. Please try again.';
          Get.snackbar('Error', errorMessage);
        }
      } else {
        Get.snackbar(
            'Error',
            parsedResponse['detail'] ??
                'Login failed. Please check your credentials.');
      }
    } catch (e) {
      debugPrint('Login Error: $e');
      Get.snackbar('Error', 'Error, please check your network');
    } finally {
      isLoading(false);
    }
  }


//  forget password function

Future<void> resetPassword() async {
  if (email.value.isEmpty || !GetUtils.isEmail(email.value)) {
    errorMessage.value = "Please enter a valid email address.";
    return;
  }

  isLoading(true); // Set loading to true
  try {
    var response = await ApiService().post(
      'https://vetkonect.com/backend/public/api/web/v2/forgot-password',
      {"email": email.value},
      Client(),
      "",
    );

    dynamic parsedResponse;
    try {
      parsedResponse = jsonDecode(response.body);
    } catch (e) {
      debugPrint("JSON Parsing Error: $e");
      errorMessage.value = "Unexpected server response. Please try again.";
      return;
    }

    // Handle response
    if (response.statusCode == 200) {
      if (parsedResponse['success'] == true) {
        successMessage.value =
            "A password reset link has been sent to ${email.value}.";
      } else {
        errorMessage.value = parsedResponse['message'] ??
            "Reset password failed. Please try again.";
      }
    } else {
      errorMessage.value = parsedResponse['message'] ??
          "Failed to send reset password link. Please check your email.";
    }
  } catch (e) {
    debugPrint('Reset Password Error: $e');
    errorMessage.value = "An error occurred while resetting the password.";
  } finally {
    isLoading(false); 
  }
}
}

Future<void> saveLoginStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('userEmail', 'example@gmail.com'); // Save any other details
}
