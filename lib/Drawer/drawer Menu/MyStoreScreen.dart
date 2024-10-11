import 'package:flutter/material.dart';

import '../../dashboard/drawer_menu.dart';

class MyStoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyStore Screen'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('This is the My Store Screen'),
      ),
    );
  }
}
