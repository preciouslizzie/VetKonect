import 'package:flutter/material.dart';

import '../../dashboard/dashborad_page/drawer_menu.dart';

class MyStoreScreen extends StatelessWidget {
  const MyStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      body: const Center(
        child: Text('This is the My Store Screen'),
      ),
    );
  }
}
