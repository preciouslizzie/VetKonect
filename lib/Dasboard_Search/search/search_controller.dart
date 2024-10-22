import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditableUserCard extends StatefulWidget {
  final String name;
  final String location;
  final String phone;
  final String email;
  final double rating;

  EditableUserCard({
    required this.name,
    required this.location,
    required this.phone,
    required this.email,
    required this.rating,
  });

  @override
  _EditableUserCardState createState() => _EditableUserCardState();
}

class _EditableUserCardState extends State<EditableUserCard> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController locationController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late double rating;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    locationController = TextEditingController(text: widget.location);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
    rating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : null,
                  child: _selectedImage == null
                      ? Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                      : null,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rating:'),
                  Slider(
                    value: rating,
                    onChanged: (newRating) {
                      setState(() {
                        rating = newRating;
                      });
                    },
                    min: 0,
                    max: 5,
                    divisions: 10,
                    label: rating.toString(),
                  ),
                  Text(rating.toStringAsFixed(1)),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'name': nameController.text,
                      'location': locationController.text,
                      'phone': phoneController.text,
                      'email': emailController.text,
                      'rating': rating,
                    });
                  }
                },
                child: Text('Save Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}