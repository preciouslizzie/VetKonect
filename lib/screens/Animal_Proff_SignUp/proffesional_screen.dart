import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/screens/Animal_Proff_SignUp/sign_up_controller.dart';
import 'package:vet_konect/screens/sign_up/sucess_alert_screen.dart';


class ProfessionalDetailsScreen extends StatelessWidget {
  final ProffSignUpController signUpController = Get.find<ProffSignUpController>();

  final TextEditingController licenseController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              
              TextField(
                controller: licenseController,
                decoration: const InputDecoration(
                  labelText: 'Practicing License Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              TextField(
                controller: facebookController,
                decoration: const InputDecoration(
                  labelText: 'Facebook Handle',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: twitterController,
                decoration: const InputDecoration(
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
