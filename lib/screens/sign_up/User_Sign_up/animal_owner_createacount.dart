import 'package:flutter/material.dart';
import 'package:vet_konect/dashboard/dashborad_page/dashboard_page.dart';
import 'package:vet_konect/screens/sign_up/User_Sign_up/Basicuser_sign_up.dart';

class AnimalOwnerAccount extends StatefulWidget {
  const AnimalOwnerAccount({super.key});

  @override
  _AnimalOwnerAccountState createState() => _AnimalOwnerAccountState();
}

class _AnimalOwnerAccountState extends State<AnimalOwnerAccount> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? selectedCategory;
  String? selectedCountry;
  String? selectedState;

  // Checkboxes and options
  bool isAgreed = false;

  // Dropdown data
  final List<String> categories = [
    'Pet Owner',
    'Livestock Farmer',
    'Vendor',
    'Others'
  ];
  final List<String> africanCountries = [
    'Nigeria', 'Kenya', 'South Africa', 'Egypt', 'Ghana', 'Ethiopia', 'Morocco',
    'Algeria', 'Tanzania', 'Uganda'
    // Add more African countries as needed
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone No.'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Category'),
              value: selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Country'),
              value: selectedCountry,
              items: africanCountries.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                  selectedState = null; // Reset state when country changes
                });
              },
            ),
            const SizedBox(height: 10),
            if (selectedCountry != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select State'),
                value: selectedState,
                items: statesByCountry[selectedCountry]!.map((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                  });
                },
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: isAgreed,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      isAgreed = value!;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'Confirm that you agree to our terms and conditions at Vet Konect',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isAgreed
                  ? _handleProceed
                  : null, // Only enabled when checkbox is checked
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isAgreed ? Theme.of(context).primaryColor : Colors.green,
                padding: EdgeInsets.all(16),
              ),
              child: Center(child: Text('Proceed')),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BasicUserSignUp()));
                // Add logic for the back button if needed
              },
              style: OutlinedButton.styleFrom(padding: EdgeInsets.all(16),
              backgroundColor: Colors.orange),
              child: Center(child: Text('Back')),
            ),
          ],
        ),
      ),
    );
  }

  void _handleProceed() {
    // Logic for proceeding to the user type controller
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DashboardScreen() // Replace with actual navigation target
      ),
    );
  }
}

