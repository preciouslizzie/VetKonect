import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../dashboard/dashborad_page/dashboard_page.dart';


class AnimalOwnerAccount extends StatefulWidget {
  const AnimalOwnerAccount({super.key});

  @override
  _AnimalOwnerAccountState createState() => _AnimalOwnerAccountState();
}

class _AnimalOwnerAccountState extends State<AnimalOwnerAccount> {
  // Controllers for user input fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;
  bool _isAgreed = false;

  /// Method to handle API call or actions after form submission
  Future<void> registerAnimalOwnerStageTwo() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      debugPrint('API call succeeded');
    } catch (e) {
      throw Exception('Failed to register. Please try again.');
    }
  }

  /// Handles the submission of form details
  void _submitDetails() async {
    if (!_isAgreed) {
      Get.snackbar(
        'Notice',
        'Please agree to the terms and conditions.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Collecting user input into a map for submission
    final userDetails = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'country': _selectedCountry ?? 'Not selected',
      'state': _selectedState ?? 'Not selected',
      'city': _selectedCity ?? 'Not selected',
    };

    try {
      await registerAnimalOwnerStageTwo();

      Get.to(() => const DashboardScreen(userDetails: {},), arguments: userDetails);

      Get.snackbar(
        'Success',
        'Account registration successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Helper method to create consistent input decoration
  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // First Name Input
            TextField(
              controller: _firstNameController,
              decoration: _buildInputDecoration('Enter your first name'),
            ),
            const SizedBox(height: 10),

            // Last Name Input
            TextField(
              controller: _lastNameController,
              decoration: _buildInputDecoration('Enter your last name'),
            ),
            const SizedBox(height: 10),

            // Phone Number Input
            TextField(
              controller: _phoneController,
              decoration: _buildInputDecoration('Enter your phone number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),

            // Address Input
            TextField(
              controller: _addressController,
              decoration: _buildInputDecoration('Enter your address'),
            ),
            const SizedBox(height: 10),

            // Country, State, City Picker
            SelectState(
              onCountryChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  _selectedState = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  _selectedCity = value;
                });
              },
            ),
            const SizedBox(height: 10),

            // Terms and Conditions Checkbox
            Row(
              children: [
                Checkbox(
                  value: _isAgreed,
                  onChanged: (value) {
                    setState(() {
                      _isAgreed = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),
                const Expanded(
                  child: Text(
                    'Confirm that you agree to our terms and conditions at Vet Konect',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Proceed Button
            ElevatedButton(
              onPressed: _submitDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Proceed'),
            ),
            const SizedBox(height: 10),

            // Back Button
            OutlinedButton(
              onPressed: () {
                Get.back(); // Using GetX to navigate back
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                side: const BorderSide(color: Colors.orange),
              ),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }}