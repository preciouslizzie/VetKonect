import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/services/users.service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Get.find<UsersService>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
