import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserTypeController extends GetxController {
  var selectedUserType = ''.obs;
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;

  /// Save Auth Token
  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  /// Retrieve Auth Token
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  /// Handle API Response
  void handleApiResponse(http.Response response, {String successMessage = ''}) {
    try {
      final parsedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (successMessage.isNotEmpty) {
          Get.snackbar('Success', successMessage);
        }
        if (parsedResponse['token'] != null) {
          saveAuthToken(parsedResponse['token']);
        }
      } else {
        final errorMessage = parsedResponse['message'] ?? 'An error occurred.';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      Get.snackbar('Error', 'Invalid response format. Please try again.');
    }
  }

  /// Post Request Helper
  Future<void> _postRequest({
    required String url,
    required Map<String, dynamic> body,
    required String successMessage,
  }) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      handleApiResponse(response, successMessage: successMessage);
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  /// Register Stage 1
  Future<void> registerAnimalOwnerStageOne() async {
    await _postRequest(
      url:
          'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
      body: {"stage": '1', "email": email.value, "password": password.value},
      successMessage: 'Stage 1 registration successful.',
    );
  }

  /// Register Stage 2
  Future<void> registerAnimalOwnerStageTwo({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final url = 'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner';

    final body = {
      "stage": '2',
      "email": email.value,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
    };

    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Stage 2 registration successful.');
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Unknown error';
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Register Stage 3
  Future<void> registerAnimalOwnerStageThree(String activationCode) async {
    await _postRequest(
      url:
          'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
      body: {
        "stage": '3',
        "email": email.value,
        "activation_code": activationCode,
      },
      successMessage: 'Account activated successfully.',
    );
  


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

Future<void> saveAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
  }
  Future<void> clearAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }


}

