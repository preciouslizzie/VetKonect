import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProffSignUpController extends GetxController {
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;
  var address = ''.obs;
  var vetNumber = ''.obs;
  var specialties = <String>[].obs;

  final String baseUrl = 'https://vetkonect.com/backend/public/api/web/v2';

  // Stage 1: Register veterinarian

  Future<void> registerVeterinarianStageOne() async {
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse('$baseUrl/registerVeterinarian?stage=1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.value,
          'password': password.value,
        }),
      );

      
    } catch (e) {
      Get.snackbar(
          'Error', 'An error occurred during Stage 1. Please try again.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Stage 2: Register veterinarian
  Future<void> registerVeterinarianStageTwo() async {
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse('$baseUrl/registerVeterinarian?stage=2'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.value,
          'first_name': firstName.value,
          'last_name': lastName.value,
          'phone_number': phoneNumber.value,
          'address': address.value,
          'vet_number': vetNumber.value,
          'speciality': specialties,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', '',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      } else {
        var errorMessage = _parseError(response);
        Get.snackbar('Error', errorMessage,
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'An error occurred during Stage 2. Please try again.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Stage 3: Register veterinarian

  Future<void> registerVeterinarianStageThree(String activationCode) async {
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse('$baseUrl/registerVeterinarian?stage=3'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.value,
          'activation_code': activationCode,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', '',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
        Get.toNamed('/create-account');
      } else {
        var errorMessage = _parseError(response);
        Get.snackbar('Error', errorMessage,
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'An error occurred during Stage 3. Please try again.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Utility: Parse error from server response
  String _parseError(http.Response response) {
    try {
      var parsedResponse = jsonDecode(response.body);
      if (parsedResponse is Map<String, dynamic> &&
          parsedResponse.containsKey('message')) {
        return parsedResponse['message'];
      }
    } catch (e) {
      debugPrint('Error parsing server response: $e');
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
