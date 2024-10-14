import 'package:flutter/material.dart';

import '../../dashboard/dashborad_page/drawer_menu.dart';

class VendorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendoer Screen'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('This is the vendor Screen'),
      ),
    );
  }
}
