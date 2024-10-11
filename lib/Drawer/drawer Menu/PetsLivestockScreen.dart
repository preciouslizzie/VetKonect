import 'package:flutter/material.dart';

import '../../dashboard/drawer_menu.dart';

class PetsLivestockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pets livestock'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('This is the Pets Livestock Screen'),
      ),
    );
  }
}
