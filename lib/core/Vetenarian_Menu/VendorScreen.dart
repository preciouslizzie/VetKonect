import 'package:flutter/material.dart';


class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendoer Screen'),
      ),
      //drawer: const DrawerMenu(),
      body: const Center(
        child: Text('This is the vendor Screen'),
      ),
    );
  }
}
