import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/sign_up/sucess_alert_screen.dart';
import 'sign_up_controller.dart';

class ProfessionalDetailsScreen extends StatelessWidget {
  final SignUpController signUpController = Get.find<SignUpController>();

  final TextEditingController licenseController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professional Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              
              TextField(
                controller: licenseController,
                decoration: InputDecoration(
                  labelText: 'Practicing License Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),

              TextField(
                controller: facebookController,
                decoration: InputDecoration(
                  labelText: 'Facebook Handle',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              TextField(
                controller: twitterController,
                decoration: InputDecoration(
                  labelText: 'Twitter Handle',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (licenseController.text.isEmpty || phoneController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please fill all required fields',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  signUpController.saveProfessionalDetails(
                    licenseNumber: licenseController.text.trim(),
                    phoneNumber: phoneController.text.trim(),
                    facebookHandle: facebookController.text.trim(),
                    twitterHandle: twitterController.text.trim(),
                  );

                  Get.to(() => SuccessAlertScreen());
                },
                child: Text('Proceed'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
