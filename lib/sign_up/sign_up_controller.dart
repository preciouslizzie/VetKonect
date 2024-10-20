import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vet_konect/sign_up/proffesional_screen.dart';

class SignUpController extends GetxController {
  var selectedRole = ''.obs;
  var isLoading = false.obs;

  void signUp(String email, String password, String confirmPassword,
      String trim, String trin) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Error',
        'Password should be at least 6 characters',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(Duration(seconds: 2));

      // TODO: Implement actual sign-up logic (e.g., API call, Firebase Auth)

      Get.to(() => ProfessionalDetailsScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign up failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void saveProfessionalDetails({
    required String licenseNumber,
    required String phoneNumber,
    String? facebookHandle,
    String? twitterHandle,
    // continue here
  }) {
    // Implement logic to save professional details
  }

  var selectedImagePath = ''.obs;
  

  final ImagePicker _picker = ImagePicker();

  void pickImage(ImageSource imageSource) async {
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }
}

Future<void> requestCameraPermission() async {
  PermissionStatus status = await Permission.camera.request();

  if (status.isGranted) {
    const GetSnackBar(
      message: 'Success',
    );
  } else {
    // Permission denied, handle it here
  }
}
