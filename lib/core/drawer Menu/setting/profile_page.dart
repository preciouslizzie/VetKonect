import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String category;
  final String country;

  UserProfilePage({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.category,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: $firstName', style: TextStyle(fontSize: 18)),
            Text('Last Name: $lastName', style: TextStyle(fontSize: 18)),
            Text('Phone: $phone', style: TextStyle(fontSize: 18)),
            Text('Address: $address', style: TextStyle(fontSize: 18)),
            Text('Category: $category', style: TextStyle(fontSize: 18)),
            Text('Country: $country', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
