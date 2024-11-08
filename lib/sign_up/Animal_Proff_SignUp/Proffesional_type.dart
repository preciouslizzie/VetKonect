import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/sign_up/Animal_Proff_SignUp/proff-basic_sign_up.dart';
import 'package:vet_konect/sign_up/Animal_Proff_SignUp/sign_up_controller.dart';

class AnimalHealthProSelectionScreen extends StatelessWidget {
  final ProffSignUpController controller = Get.find<ProffSignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Professional Type')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'I am signing up as:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                controller.signUp;
                Get.to(() => ProffBasicSignUp());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white, 
                ),
                child: const Row(
                  children:  [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(Icons.agriculture, size: 30, color: Colors.green),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Veterinarian',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Pet Owner Button
            GestureDetector(
              onTap: () {
                controller.signUp;
                Get.to(() => ProffBasicSignUp());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Row(
                  children:  [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(Icons.pets, size: 30, color: Colors.green),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Vet Paraprofessional',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            )])));}}