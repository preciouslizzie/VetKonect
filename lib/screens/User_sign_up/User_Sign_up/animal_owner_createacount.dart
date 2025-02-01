import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

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
    if (!_formKey.currentState!.validate() ||
        _selectedCountry == null ||
        _selectedState == null ||
        _selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields, including country, state, and city')),
      );
      return;
    }

    try {
      userTypeController.firstName.value = _firstNameController.text;
      userTypeController.lastName.value = _lastNameController.text;
      userTypeController.phoneNumber.value = _phoneController.text;

      await userTypeController.registerAnimalOwnerStageTwo(
        firstName: userTypeController.firstName.value,
        lastName: userTypeController.lastName.value,
        phoneNumber: userTypeController.phoneNumber.value,
      );

      if (userTypeController.isLoading.isFalse) {
        Get.toNamed('/activation-code', arguments: {
          'email': userTypeController.email.value,
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
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
              FormField<String>(
                validator: (value) {
                  if (_selectedCountry == null) return 'Please select a country';
                  if (_selectedState == null) return 'Please select a state';
                  if (_selectedCity == null) return 'Please select a city';
                  return null;
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectState(
                        onCountryChanged: (value) {
                          _selectedCountry = value;
                          field.didChange(value);
                        },
                        onStateChanged: (value) {
                          _selectedState = value;
                          field.didChange(value);
                        },
                        onCityChanged: (value) {
                          _selectedCity = value;
                          field.didChange(value);
                        },
                      ),
                      if (field.hasError)
                        Text(
                          field.errorText ?? '',
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  );
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
