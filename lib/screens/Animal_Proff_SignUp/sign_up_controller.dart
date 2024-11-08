import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'proffesional_screen.dart';

class ProffSignUpController extends GetxController {
  var selectedRole = ''.obs;
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var selectedImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final String baseUrl = 'https://vetkonect.com/backend/public/api/web/v2';

  // Multi-Stage Sign-Up Process
  void signUp(
    String email,
    String password,
    String confirmPassword,
    String firstName,
    String lastName,
    String phoneNumber,
    String address,
    String vetNumber,
    List<String> specialties,
  ) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showSnackbar('Error', 'Please fill all fields');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      _showSnackbar('Error', 'Please enter a valid email address');
      return;
    }

    if (password.length < 6) {
      _showSnackbar('Error', 'Password should be at least 6 characters');
      return;
    }

    if (password != confirmPassword) {
      _showSnackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading.value = true;

    try {
      var stage1Response = await http.post(
        Uri.parse('$baseUrl/registerVeterinarian?stage=1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (stage1Response.statusCode != 200) {
        _showSnackbar('Error', 'Signup failed at stage 1. Please check your email and password.');
        return;
      }

      // Stage 2: Additional details
      var stage2Response = await http.post(
        Uri.parse('$baseUrl/registerVeterinarian?stage=2'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneNumber,
          'address': address,
          'vet_number': vetNumber,
          'speciality': specialties,
        }),
      );

      if (stage2Response.statusCode != 200) {
        _showSnackbar('Error', 'Signup failed at stage 2. Please check your information.');
        return;
      }

      // Request activation code from user
      String activationCode = await _promptForActivationCode();

      // Stage 3: Verification
      var stage3Response = await http.post(
        Uri.parse('$baseUrl/registerVeterinarian?stage=3'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'activation_code': activationCode,
        }),
      );

      if (stage3Response.statusCode == 200) {
        Get.to(() => ProfessionalDetailsScreen());
      } else {
        _showSnackbar('Error', 'Signup failed at stage 3. Incorrect activation code.');
      }
    } catch (e) {
      _showSnackbar('Error', 'Sign up failed. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> _promptForActivationCode() async {
    String? activationCode = await Get.defaultDialog<String>(
      title: "Enter Activation Code",
      content: TextField(
        onSubmitted: (value) {
          Get.back(result: value);
        },
        decoration: InputDecoration(labelText: "Activation Code"),
      ),
    );
    return activationCode ?? '';
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  // Google Login
  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _showSnackbar('Error', 'Google sign-in cancelled');
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/google/loginUsingGoogle?email=${googleUser.email}'),
      );

      if (response.statusCode == 200) {
        Get.to(() => ProfessionalDetailsScreen());
      } else {
        _showSnackbar('Error', 'Failed to login with Google');
      }
    } catch (e) {
      _showSnackbar('Error', 'Google login failed. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // LinkedIn Login
  Future<void> loginWithLinkedIn() async {
    try {
      isLoading.value = true;
      
      final response = await http.get(Uri.parse('$baseUrl/linkedin/loginUsingLinkedin'));

      if (response.statusCode == 200) {
        Get.to(() => ProfessionalDetailsScreen());
      } else {
        _showSnackbar('Error', 'Failed to login with LinkedIn');
      }
    } catch (e) {
      _showSnackbar('Error', 'LinkedIn login failed. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // Facebook Login
  
  // Image Selection and Upload
  void pickImage(ImageSource imageSource) async {
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      await uploadProfileImage(pickedFile);
    } else {
      _showSnackbar("Error", "No image selected");
    }
  }

  Future<void> uploadProfileImage(XFile imageFile) async {
    isLoading.value = true;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload-profile-image'),
      );
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Profile image uploaded successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        _showSnackbar('Error', 'Failed to upload image');
      }
    } catch (e) {
      _showSnackbar('Error', 'Image upload failed. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}

class FacebookAuth {
}

// Camera Permission Handling
Future<void> requestCameraPermission() async {
  PermissionStatus status = await Permission.camera.request();

  if (status.isGranted) {
    Get.snackbar('Success', 'Camera permission granted');
  } else {
    Get.snackbar('Error', 'Camera permission denied');
  }
}
