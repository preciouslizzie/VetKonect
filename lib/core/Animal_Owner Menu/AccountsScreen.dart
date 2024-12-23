import 'package:flutter/material.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acccount Screen'),
      ),
      body: const Center(
        child: Text('This is the Account Screen'),
      ),
    );
  }
}
