import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/dashboard/dashborad_page/dashboard_page.dart';

class AnimalOwnerAccount extends StatefulWidget {
  const AnimalOwnerAccount({super.key});

  @override
  _AnimalOwnerAccountState createState() => _AnimalOwnerAccountState();
}

class _AnimalOwnerAccountState extends State<AnimalOwnerAccount> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;
  bool _isAgreed = false;

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
      Get.to(() => DashboardScreen(), arguments: userDetails);
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
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: _buildInputDecoration('Enter your first name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _lastNameController,
              decoration: _buildInputDecoration('Enter your last name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: _buildInputDecoration('Enter your phone number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: _buildInputDecoration('Enter your address'),
            ),
            SizedBox(height: 10),
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
  countryDecoration: _buildInputDecoration('Select Country'),
  stateDecoration: _buildInputDecoration('Select State'),
  cityDecoration: _buildInputDecoration('Select City'),
),

            SizedBox(height: 10),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitDetails,
              child: Text('Proceed'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Get.back(); // Using GetX to navigate back
              },
              child: Text('Back'),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                side: BorderSide(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
