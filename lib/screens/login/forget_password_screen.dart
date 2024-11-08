import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/screens/login/login_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your email to reset your password:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                controller.email.value = value; 
              },
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () {
                      controller.login(); // Call the API when button is clicked
                    },
                    child: Text('Send Password Reset Link'),
                  )),
          ],
        ),
      ),
    );
  }
}
