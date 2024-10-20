import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsCard(
              icon: Icons.person,
              title: 'Profile',
              iconColor: Colors.blue,
              onTap: () {
                Get.toNamed('/profile');
              },
            ),
            const SizedBox(height: 10), 
            SettingsCard(
              icon: Icons.info,
              title: 'About Us',
              iconColor: Colors.pink,
              onTap: () {
                Get.toNamed('/about');
              },
            ),
            const SizedBox(height: 10),
            SettingsCard(
              icon: Icons.logout,
              title: 'Log Out',
              iconColor: Colors.orange,
              onTap: () {
                Get.toNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;

  SettingsCard({required this.icon, required this.title, required this.onTap, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), 
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              // Icon with background circle
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 30, color: iconColor),
              ),
              SizedBox(width: 20),
              // Title Text
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
