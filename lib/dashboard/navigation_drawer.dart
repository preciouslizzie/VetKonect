import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/config/assets.dart';
import 'package:vet_konect/dashboard/dashborad_page/drawer_menu.dart';
import 'package:vet_konect/screens/login/login_view.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Image.asset(Assets.imgLogin, height: 50),
                const Spacer(),
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(Assets.imgLogin),
                ),
              ],
            ),
          ),
          _buildDrawerItem(icon: Icons.home, text: 'Home', onTap: () {
            Get.to(DrawerMenu());
          }),
          _buildDrawerItem(icon: Icons.dashboard, text: 'Dashboard', onTap: () {}),
          // Add other drawer items...
          _buildDrawerItem(icon: Icons.logout, text: 'Log Out', onTap: () {
            Get.offAll(LoginScreen());
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(text),
      onTap: onTap,
    );
  }
  
  Icon(IconData icon, {required MaterialColor color}) {}
}
