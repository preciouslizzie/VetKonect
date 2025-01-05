import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Animal_Owner Menu/setting/profile_page.dart';
import 'user_controller.dart';

// ignore: must_be_immutable
class AnimalOwnerAccount extends StatelessWidget {
  final UserTypeController userTypeController = Get.put(UserTypeController());
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  AnimalOwnerAccount({super.key});

  void _submitDetails(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Bind user input to controller fields
    userTypeController.firstName.value = _firstNameController.text;
    userTypeController.lastName.value = _lastNameController.text;
    userTypeController.phoneNumber.value = _phoneController.text;

    // Call API for stage 2 registration
    await userTypeController.registerAnimalOwnerStageTwo(
      firstName: userTypeController.firstName.value,
      lastName: userTypeController.lastName.value,
      phoneNumber: userTypeController.phoneNumber.value,
    );

    if (userTypeController.isLoading.isFalse) {
      final userDetails = {
        'firstName': userTypeController.firstName.value,
        'lastName': userTypeController.lastName.value,
        'phone': userTypeController.phoneNumber.value,
        'address': _addressController.text,
        'country': _selectedCountry ?? 'Not selected',
        'state': _selectedState ?? 'Not selected',
        'city': _selectedCity ?? 'Not selected',
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfilePage(userDetails: userDetails),
        ),
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
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: _buildInputDecoration('Enter your first name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _lastNameController,
                decoration: _buildInputDecoration('Enter your last name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: _buildInputDecoration('Enter your phone number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: _buildInputDecoration('Enter your address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              SelectState(
                onCountryChanged: (value) {
                  _selectedCountry = value;
                },
                onStateChanged: (value) {
                  _selectedState = value;
                },
                onCityChanged: (value) {
                  _selectedCity = value;
                },
              ),
              const SizedBox(height: 10),
              Obx(
                () => userTypeController.isLoading.isTrue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () => _submitDetails(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text('Proceed'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
