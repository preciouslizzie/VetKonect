import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/screens/login/login_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter your email to reset your password:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  controller.email.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.loginFunction();
                          }
                        },
                        child: const Text(
                          'Send Password Reset Link',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              const SizedBox(height: 20),
              Obx(() => controller.errorMessage.value.isNotEmpty
                  ? Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    )
                  : Container()),
              Obx(() => controller.successMessage.value.isNotEmpty
                  ? Text(
                      controller.successMessage.value,
                      style: const TextStyle(color: Colors.green),
                    )
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }
}
