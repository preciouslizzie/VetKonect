import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../network folder/api_services.dart';

class UserTypeController extends GetxController {
  var selectedUserType = ''.obs;
  var selectedRole = ''.obs;
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var selectedImagePath = ''.obs;
  var stage = 1.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;

  /// Handles API response parsing and common error handling
  void handleApiResponse(http.Response response, {String successMessage = ''}) {
    try {
      final parsedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && parsedResponse['success'] == true) {
        Get.snackbar('Success', parsedResponse['message'] ?? successMessage);
        if (successMessage.isNotEmpty) Get.toNamed('/create-account');
      } else {
        final errorMessage = parsedResponse['message'] ??
            'An error occurred. Please check your input.';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      debugPrint('Error parsing response: $e');
      Get.snackbar('Error', 'Invalid server response. Please try again.');
    }
  }

  Future<void> _postRequest({
    required String url,
    required Map<String, dynamic> body,
    required String successMessage,
  }) async {
    isLoading(true);
    try {
      final response = await ApiService().post(url, body, Client(), "");
      debugPrint('Response: ${response.body}');
      handleApiResponse(response, successMessage: successMessage);
    } catch (e) {
      debugPrint('Error during API call: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  // Sets the user type
  Future<void> setUserType(String userType) async {
    selectedUserType.value = userType;
    await _postRequest(
      url:
          'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
      body: {"UserType": userType, "password": password.value},
      successMessage: 'User type successfully set.',
    );
  }

  /// Stage 1:
  Future<void> registerAnimalOwnerStageOne() async {
    await _postRequest(
      url:
          'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
      body: {"stage": '1', "email": email.value, "password": password.value},
      successMessage: 'Animal owner registration stage 1 complete.',
    );
  }

  /// Stage 2:
  Future<void> registerAnimalOwnerStageTwo({
  required String email,
  required String firstName,
  required String lastName,
  required String phoneNumber,
}) async {
  final String url =
      'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner';

  final Map<String, dynamic> body = {
    "stage": '2',
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('Animal owner registration stage 2 complete.');
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to register: $error');
    }
  } catch (e) {
    print('Error during registration: $e');
    rethrow; // Rethrow the error to handle it at a higher level if needed
  }
}
  

  /// Stage 3:
  Future<void> registerAnimalOwnerStageThree() async {
    await _postRequest(
      url:
          'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
      body: {
        "stage": '3',
        "email": email.value,
        "activation_code": password.value,
      },
      successMessage: 'Animal owner account activated successfully.',
    );
  }

  /// General signup for veterinarians (can add more roles if needed)
  Future<void> signUpVeterinarian() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty.');
      return;
    }

    await _postRequest(
      url:
          'https://vetkonect.com/backend/public/api/web/v2/registerVeterinarian',
      body: {"email": email.value, "password": password.value},
      successMessage: 'Veterinarian signup successful.',
    );
  }
}
