import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/screens/Animal_Proff_SignUp/Proffesional_type.dart';
import 'package:vet_konect/screens/sign_up/User_Sign_up/user_controller.dart';
import 'User_Sign_up/User_type.dart';

class SignUpScreen extends StatelessWidget {
  final UserTypeController userTypeController = Get.find<UserTypeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Sign Up As:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                userTypeController.setUserType('', '');
                Get.to(() => UserTypeSelectionScreen());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(Icons.person, size: 30, color: Colors.green),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Animal Owner',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                userTypeController.setUserType('', '');
                Get.to(() => AnimalHealthProSelectionScreen());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(Icons.medical_services_rounded,
                          size: 30, color: Colors.green),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        'Animal Health Professional',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    )
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
