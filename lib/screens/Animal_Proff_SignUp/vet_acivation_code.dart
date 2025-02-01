import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VetActivationPage extends StatefulWidget {
  const VetActivationPage({super.key});

  @override
  _VetActivationPageState createState() => _VetActivationPageState();
}

class _VetActivationPageState extends State<VetActivationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _activationCodeController = TextEditingController();

  bool isLoading = false;

  Future<void> verifyVetActivationCode() async {
    const String url = "https://vetkonect.com/backend/public/api/web/v2/registerVeterinarian";

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": _emailController.text.trim(),
          "activation_code": _activationCodeController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          Get.snackbar(
            'Success',
            'Veterinarian account activated successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          Get.offAllNamed('/login'); 
          
        } else {
          Get.snackbar(
            'Error',
            data['message'] ?? 'Failed to activate veterinarian account.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Server error. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vet Activation'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Activate Veterinarian Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Email Input
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Activation Code Input
            TextField(
              controller: _activationCodeController,
              decoration: InputDecoration(
                labelText: 'Activation Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Verify Button
            ElevatedButton(
              onPressed: isLoading ? null : verifyVetActivationCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Activate Account'),
            ),
          ],
        ),
      ),
    );
  }
}
