import 'package:flutter/material.dart';

import '../../dashboard/drawer_menu.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('This is the Profile Screen'),
      ),
    );
  }
}