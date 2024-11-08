import 'package:flutter/material.dart';

class AddNewPetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Pet'),
      ),
      body: const Center(
        child: Text(
          'This is the page to add a new pet!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
