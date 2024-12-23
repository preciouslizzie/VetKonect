import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SocialMediaController extends GetxController {
  var isLoading = false.obs;

  // Backend URLs
  final String googleLoginUrl =
      "https://vetkonect.com/backend/public/api/google/loginUsingGoogle";
  final String linkedInLoginUrl =
      "https://vetkonect.com/backend/public/api/linkedin/loginUsingLinkedin";

  // Google Login via Backend
  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(googleLoginUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Google login successful! Response: $data");
        // TODO: Handle the response, such as saving tokens or user details.
      } else {
        print("Google login failed: ${response.body}");
        Get.snackbar("Error", "Google login failed");
      }
    } catch (e) {
      print("Error during Google login: $e");
      Get.snackbar("Error", "Something went wrong with Google login");
    } finally {
      isLoading.value = false;
    }
  }

  // LinkedIn Login via Backend
  Future<void> loginWithLinkedIn() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(linkedInLoginUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("LinkedIn login successful! Response: $data");
        // TODO: Handle the response, such as saving tokens or user details.
      } else {
        print("LinkedIn login failed: ${response.body}");
        Get.snackbar("Error", "LinkedIn login failed");
      }
    } catch (e) {
      print("Error during LinkedIn login: $e");
      Get.snackbar("Error", "Something went wrong with LinkedIn login");
    } finally {
      isLoading.value = false;
    }
  }
}
