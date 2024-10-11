import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/sign_up/create_account%20_screen.dart';
import 'sign_up_controller.dart';


class SignUpScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign up as:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                signUpController.selectedRole.value = 'Veterinary Doctor';
                Get.to(() => CreateAccountScreen());
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.person, size: 50, color: Colors.green),
                    SizedBox(width: 16),
                    Text(
                      'As Veterinary Doctor',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                signUpController.selectedRole.value = 'Veterinary Paraprofessional';
                Get.to(() => CreateAccountScreen());
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.medical_services, size: 50, color: Colors.green),
                    SizedBox(width: 16),
                    Text(
                      'As Veterinary Paraprofessional',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
