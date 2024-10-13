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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                '${users.x.value}',
              ),
            ),
            const SizedBox(height: 40),
            TextButton.icon(
              onPressed: () {
                users.x.value ++;
              },
              icon: Icon(Icons.add),
              label: Text('Add X'),
            ),
          ],
        ),
      ),
    );
  }
}
