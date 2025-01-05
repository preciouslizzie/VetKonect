import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VetCreateAcctScreen extends StatefulWidget {
  const VetCreateAcctScreen({Key? key}) : super(key: key);

  @override
  _VetCreateAcctScreenState createState() => _VetCreateAcctScreenState();
}

class _VetCreateAcctScreenState extends State<VetCreateAcctScreen> {
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _xHandleController = TextEditingController();
  final TextEditingController _instagramHandleController = TextEditingController();
  final TextEditingController _facebookHandleController = TextEditingController();
  final TextEditingController _linkedinHandleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _selectedImage;
  bool _isAgreementChecked = false;

  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (!_isAgreementChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the terms and conditions.')),
      );
      return;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload an image.')),
      );
      return;
    }

    // Simulate form submission or API call
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('successfull')),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Practicing License Number
              TextFormField(
                controller: _licenseNumberController,
                decoration: _buildInputDecoration('Practicing License Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'License number is required.';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              const Text(
                'Awaiting License number ',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? const Center(child: Text('Add Image'))
                      : null,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Or you can upload a license card',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _firstNameController,
                decoration: _buildInputDecoration('First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'First name is required.';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _lastNameController,
                decoration: _buildInputDecoration('Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Last name is required.';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: _buildInputDecoration('Specialty'),
                items: ['Veterinary', 'Surgery', 'Dentistry']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  _specialtyController.text = value ?? '';
                },
              ),
              const SizedBox(height: 16),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                decoration: _buildInputDecoration('Phone No'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Phone number is required.';
                  if (!RegExp(r'^\d{10,15}$').hasMatch(value)) return 'Enter a valid phone number.';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // X Handle
              TextFormField(
                controller: _xHandleController,
                decoration: _buildInputDecoration('X handle'),
              ),
              const SizedBox(height: 16),

              // Instagram Handle
              TextFormField(
                controller: _instagramHandleController,
                decoration: _buildInputDecoration('Instagram handle'),
              ),
              const SizedBox(height: 16),

              // Facebook Handle
              TextFormField(
                controller: _facebookHandleController,
                decoration: _buildInputDecoration('Facebook handle'),
              ),
              const SizedBox(height: 16),

              // LinkedIn Handle
              TextFormField(
                controller: _linkedinHandleController,
                decoration: _buildInputDecoration('LinkedIn handle'),
              ),
              const SizedBox(height: 16),

              // Address
              TextFormField(
                controller: _addressController,
                decoration: _buildInputDecoration('Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Address is required.';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Agreement Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _isAgreementChecked,
                    onChanged: (value) {
                      setState(() {
                        _isAgreementChecked = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Confirm that you agree to our terms and conditions at Vet Konect',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Proceed', 
                textAlign: TextAlign.center,),
              ),

              const SizedBox(
                height: 20,
                ),

              // Back Button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
