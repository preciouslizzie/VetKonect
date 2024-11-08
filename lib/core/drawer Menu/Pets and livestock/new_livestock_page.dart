import 'package:flutter/material.dart';

class AddNewLiveStockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New LiveStock'),
      ),
      body: const Center(
        child: Text(
          'This is the page to add a new livestock!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
