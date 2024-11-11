import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/dashboard/dashborad_page/dashboard_page.dart'; // Import your Dashboard page

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

  String? _selectedCategory;
  String? _selectedCountry;
  bool _isAgreed = false;

  final List<String> categories = [
    'Pet Owner',
    'Livestock Farmer',
    'Vendor',
    'Others'
  ];
  final List<String> africanCountries = [
    'Nigeria', 'Kenya', 'South Africa', 'Egypt', 'Ghana', 'Ethiopia', 'Morocco',
    'Algeria', 'Tanzania', 'Uganda'
  ];
  final Map<String, List<String>> statesByCountry = {
    'Nigeria': ['Lagos', 'Abuja', 'Kano', 'Oyo'],
    'Kenya': ['Nairobi', 'Mombasa', 'Kisumu'],
    'South Africa': ['Gauteng', 'Western Cape', 'KwaZulu-Natal'],
    'Egypt': ['Cairo', 'Alexandria', 'Giza'],
    'Ghana': ['Accra', 'Kumasi', 'Tamale'],
    'Ethiopia': ['Addis Ababa', 'Dire Dawa'],
    'Morocco': ['Rabat', 'Casablanca'],
    'Algeria': ['Algiers', 'Oran'],
    'Tanzania': ['Dar es Salaam', 'Dodoma'],
    'Uganda': ['Kampala', 'Entebbe'],
  };

  void _proceedToProfile() {
    if (_isAgreed) {
      Get.to(() => DashboardScreen(), arguments: {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'category': _selectedCategory ?? 'Not selected',
        'country': _selectedCountry ?? 'Not selected',
      });
    } else {
      Get.snackbar(
        'Notice',
        'Please agree to the terms and conditions.',
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
        borderRadius: BorderRadius.circular(30.0),
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
            DropdownButtonFormField<String>(
              decoration: _buildInputDecoration('Select Category'),
              value: _selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: _buildInputDecoration('Select Country'),
              value: _selectedCountry,
              items: africanCountries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
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
              onPressed: _proceedToProfile,
              child: Text('Proceed'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
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
