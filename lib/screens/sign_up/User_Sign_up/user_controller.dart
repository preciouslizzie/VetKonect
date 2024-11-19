import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vet_konect/network%20folder/api_services.dart';

class UserTypeController extends GetxController {
  var selectedUserType = ''.obs;
  var selectedRole = ''.obs;
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var selectedImagePath = ''.obs;
  var stage = 1;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber =  ''.obs;

  Future<void> setUserType(String userType, String email) async {
    selectedUserType.value = userType;

    isLoading(true);

    try {
      var response = await ApiService().post(
        'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
        {"UserType": selectedUserType.value, "password": password.value},
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
        if (parsedResponse['success'] == true ||
            parsedResponse.containsKey('message')) {
          Get.snackbar('Success',
              parsedResponse['message'] ?? 'User type successfully set.');
          Get.toNamed('/create-account');
        } else {
          String errorMessage = parsedResponse['message'] ??
              'Failed to set user type. Please try again.';
          Get.snackbar('Error', errorMessage);
        }
      } else if (response.statusCode == 409) {
        String errorMessage =
            parsedResponse['message'] ?? 'This email is already registered.';
        Get.snackbar('Error', errorMessage);
      } else {
        String errorMessage = parsedResponse['detail'] ??
            'Failed to set user type. Please check your input.';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      debugPrint('Error calling the backend: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
// AnimalOwner Stage One
  Future<void> registerAnimalOwnerStageOne() async {
    isLoading(true);

    try {
      var response = await ApiService().post(
        'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
        {"stage": '1', 'email': email.value, "password": password.value},
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
        if (parsedResponse['success'] == true ||
            parsedResponse.containsKey('message')) {
          Get.snackbar('Success',
              parsedResponse['message'] ?? 'User type successfully set.');
          Get.toNamed('/create-account');
        } else {
          String errorMessage = parsedResponse['message'] ??
              'Failed to set user type. Please try again.';
          Get.snackbar('Error', errorMessage);
        }
      } else if (response.statusCode == 409) {
        String errorMessage =
            parsedResponse['message'] ?? 'This email is already registered.';
        Get.snackbar('Error', errorMessage);
      } else {
        String errorMessage = parsedResponse['detail'] ??
            'Failed to set user type. Please check your input.';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      debugPrint('Error calling the backend: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

// Stage 2 for AnimalOwner
  Future<void> registerAnimalOwnerStageTwo() async {
    isLoading(true);

    try {
      var response = await ApiService().post(
        'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
        {
          "stage": '2',
          'email': email.value,
          "first_name": firstName.value,
          'last_name': lastName.value,
          'phone_number': phoneNumber.value
        },
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
        if (parsedResponse['success'] == true ||
            parsedResponse.containsKey('message')) {
          Get.snackbar('Success',
              parsedResponse['message'] ?? 'User type successfully set.');
          Get.toNamed('/create-account');
        } else {
          String errorMessage = parsedResponse['message'] ??
              'Failed to set user type. Please try again.';
          Get.snackbar('Error', errorMessage);
        }
      } else if (response.statusCode == 409) {
        String errorMessage =
            parsedResponse['message'] ?? 'This email is already registered.';
        Get.snackbar('Error', errorMessage);
      } else {
        String errorMessage = parsedResponse['detail'] ??
            'Failed to set user type. Please check your input.';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      debugPrint('Error calling the backend: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
// Animal Owner Stage 3
  Future<void> registerAnimalOwnerStageThree() async {
    isLoading(true);

    try {
      var response = await ApiService().post(
        'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
        {"stage": '1', 'email': email.value, "activation_code": password.value},
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
        if (parsedResponse['success'] == true ||
            parsedResponse.containsKey('message')) {
          Get.snackbar('Success',
              parsedResponse['message'] ?? 'User type successfully set.');
          Get.toNamed('/create-account');
        } else {
          String errorMessage = parsedResponse['message'] ??
              'Failed to set user type. Please try again.';
          Get.snackbar('Error', errorMessage);
        }
      } else if (response.statusCode == 409) {
        String errorMessage =
            parsedResponse['message'] ?? 'This email is already registered.';
        Get.snackbar('Error', errorMessage);
      } else {
        String errorMessage = parsedResponse['detail'] ??
            'Failed to set user type. Please check your input.';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      debugPrint('Error calling the backend: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
// Veterenarian Stage 1
  


// Future<void> signUpStage1() async {
//   if (email.value.isEmpty || password.value.isEmpty) {
//     Get.snackbar('Error', 'Email and password cannot be empty.');
//     return;
//   }

//   isLoading(true);
//   try {
//     var response = await ApiService().post(
//         'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
//         {"email": email.value, "password": password.value},
//         Client(),
//         "");
//     Get.snackbar('Success', 'Login Successful');
//     Get.offAllNamed('/dashboard');
//     debugPrint(response.body);
//     // if (response.body['code'] == 200) {
//     //   Get.snackbar('Success', 'Login Successful');
//     //   Get.offAllNamed('/dashboard');
//     //   if (rememberMe.value) {
//     //     box.write('email', email.value);
//     //     box.write('password', password.value);
//     //     box.write('rememberMe', true);
//     //   } else {
//     //     box.remove('email');
//     //     box.remove('password');
//     //     box.write('rememberMe', false);
//     //   }
//     // } else {
//     //   Get.snackbar('Error', 'invalid Email or Password');
//     // }

//     //  var decoded = UserModel.fromJson(json.decode(response.body));
//   } catch (e) {
//     Get.snackbar('Error', 'Please check your network and try again');
//   } finally {
//     isLoading(false);
//   }
// }
}
