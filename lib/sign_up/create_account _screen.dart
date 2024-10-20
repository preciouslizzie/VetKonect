import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dashboard/dashborad_page/dashboard_page.dart';
import 'sign_up_controller.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController xHandleController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // License Number field
              TextField(
                controller: licenseNumberController,
                decoration: const InputDecoration(
                  labelText: 'Practicing License Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Type "Awaiting" if License number is not available'),

              SizedBox(height: 16),

              // Image Picker Button
              Obx(() {
                return GestureDetector(
                  onTap: () {
                    _showImageSourceOptions(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: signUpController.selectedImagePath.value == ''
                        ? Center(child: Text('Add Image'))
                        : Image.file(
                            File(signUpController.selectedImagePath.value),
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              }),

              SizedBox(height: 16),
              Text('Or you can upload a license card'),

              // Input fields for First Name, Last Name, Specialty, and Phone Number
              SizedBox(height: 16),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: specialtyController,
                decoration: InputDecoration(
                  labelText: 'Specialty',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              SizedBox(height: 16),

              // Phone No
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone No',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),

              TextField(
                controller: xHandleController,
                decoration: const InputDecoration(
                  labelText: 'X handle',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Instagram handle
              TextField(
                controller: instagramController,
                decoration: const InputDecoration(
                  labelText: 'Instagram handle',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: facebookController,
                decoration: const InputDecoration(
                  labelText: 'Facebook handle',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: linkedInController,
                decoration: const InputDecoration(
                  labelText: 'LinkedIn handle',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Checkbox(
                    value: isTermsAccepted,
                    onChanged: (newValue) {
                      isTermsAccepted = newValue!;
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Confirm that you agree to our terms and conditions at Vet Konect',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (isTermsAccepted) {
                          Get.to(() =>
                              DashboardScreen()); // Navigate to DashboardScreen
                        } else {
                          Get.snackbar('Error',
                              'Please accept the terms and conditions');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Proceed'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle back logic
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[200],
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

void _showImageSourceOptions(BuildContext context) {
  var signUpController;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                signUpController.pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () {
                signUpController.pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
