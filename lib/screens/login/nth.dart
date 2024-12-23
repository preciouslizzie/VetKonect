// import 'package:country_state_city_picker/country_state_city_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AnimalOwnerAccount extends StatefulWidget {
//   const AnimalOwnerAccount({super.key});

//   @override
//   _AnimalOwnerAccountState createState() => _AnimalOwnerAccountState();
// }

// class _AnimalOwnerAccountState extends State<AnimalOwnerAccount> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   String? _selectedCountry;
//   String? _selectedState;
//   String? _selectedCity;
//   bool _isAgreed = false;

//   /// Helper method for consistent input decoration
//   InputDecoration _buildInputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//     );
//   }

//   /// Handles submission of form details
//   void _submitDetails() {
//     if (!_isAgreed) {
//       Get.snackbar(
//         'Notice',
//         'Please agree to the terms and conditions.',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     final userDetails = {
//       'firstName': _firstNameController.text,
//       'lastName': _lastNameController.text,
//       'phone': _phoneController.text,
//       'address': _addressController.text,
//       'country': _selectedCountry ?? 'Not selected',
//       'state': _selectedState ?? 'Not selected',
//       'city': _selectedCity ?? 'Not selected',
//     };

//     // Navigate to dashboard
//     Get.to(() => DashboardPage(), arguments: userDetails);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // First Name Input
//             TextField(
//               controller: _firstNameController,
//               decoration: _buildInputDecoration('Enter your first name'),
//             ),
//             const SizedBox(height: 10),

//             // Last Name Input
//             TextField(
//               controller: _lastNameController,
//               decoration: _buildInputDecoration('Enter your last name'),
//             ),
//             const SizedBox(height: 10),

//             // Phone Number Input
//             TextField(
//               controller: _phoneController,
//               decoration: _buildInputDecoration('Enter your phone number'),
//               keyboardType: TextInputType.phone,
//             ),
//             const SizedBox(height: 10),

//             // Address Input
//             TextField(
//               controller: _addressController,
//               decoration: _buildInputDecoration('Enter your address'),
//             ),
//             const SizedBox(height: 10),

//             // Country Picker
//             DropdownButtonFormField<String>(
//               decoration: _buildInputDecoration('Select your country'),
//               value: _selectedCountry,
//               items: ['USA', 'India', 'Canada'] // Replace with actual country list
//                   .map((country) => DropdownMenuItem(
//                         value: country,
//                         child: Text(country),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCountry = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),

//             // State Picker
//             DropdownButtonFormField<String>(
//               decoration: _buildInputDecoration('Select your state'),
//               value: _selectedState,
//               items: ['State 1', 'State 2', 'State 3'] // Replace with actual state list
//                   .map((state) => DropdownMenuItem(
//                         value: state,
//                         child: Text(state),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedState = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),

//             // City Picker
//             DropdownButtonFormField<String>(
//               decoration: _buildInputDecoration('Select your city'),
//               value: _selectedCity,
//               items: ['City A', 'City B', 'City C'] // Replace with actual city list
//                   .map((city) => DropdownMenuItem(
//                         value: city,
//                         child: Text(city),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCity = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),

//             // Terms and Conditions Checkbox
//             Row(
//               children: [
//                 Checkbox(
//                   value: _isAgreed,
//                   onChanged: (value) {
//                     setState(() {
//                       _isAgreed = value!;
//                     });
//                   },
//                   activeColor: Colors.green,
//                 ),
//                 const Expanded(
//                   child: Text(
//                     'Confirm that you agree to our terms and conditions at Vet Konect',
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Proceed Button
//             ElevatedButton(
//               onPressed: _submitDetails,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//               child: const Text('Proceed'),
//             ),
//             const SizedBox(height: 10),

//             // Back Button
//             OutlinedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               style: OutlinedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 side: const BorderSide(color: Colors.orange),
//               ),
//               child: const Text('Back'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }