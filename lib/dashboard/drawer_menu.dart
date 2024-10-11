import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/dashboard/dashboard_page.dart';
import 'package:vet_konect/feed_calculator/feed_calculator_screen.dart';
import 'package:vet_konect/login/login.dart';
import 'AccountsScreen.dart';
import '../Drawer/drawer Menu/ActivitiesScreen.dart';
import '../Drawer/drawer Menu/AdsPromotionScreen.dart';
import '../Drawer/drawer Menu/ChatForumScreen.dart';
import '../Drawer/drawer Menu/ClientsScreen.dart';
import '../Drawer/drawer Menu/DiseasePredictorScreen.dart';
import '../Drawer/drawer Menu/MyStoreScreen.dart';
import '../Drawer/drawer Menu/PetsLivestockScreen.dart';
import '../Drawer/drawer Menu/VendorScreen.dart'; // For navigation, if you're using GetX

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
            // Drawer Header (logo and profile image)
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/login_logo.png', height: 50), // App logo
                  Spacer(),
                  // Profile image (optional)
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/profile.png'), // Replace with the correct profile image path
                  ),
                ],
              ),
            ),

            // Drawer Items
            _buildDrawerItem(icon: Icons.home, text: 'Home', onTap: () {
            }),
            _buildDrawerItem(icon: Icons.dashboard, text: 'Dashboard', onTap: () {
              Get.to(DashboardContent());
            }),
            _buildDrawerItem(icon: Icons.pets, text: 'Pets & Livestocks', onTap: () {
              Get.to(PetsLivestockScreen());
            }),
            _buildDrawerItem(icon: Icons.people, text: 'Clients', onTap: () {
              Get.to(ClientsScreen());
            }),
            _buildDrawerItem(icon: Icons.forum, text: 'Chat Forum', onTap: () {
              Get.to(ChatForumScreen());
            }),
            _buildDrawerItem(icon: Icons.store, text: 'Vendor', onTap: () {
              Get.to(VendorScreen());
            }),
            _buildDrawerItem(icon: Icons.calculate, text: 'Feed Calculator', onTap: () {
              Get.to(FeedCalculatorScreen());
            }),
            _buildDrawerItem(icon: Icons.local_hospital, text: 'Disease Predictor', onTap: () {
              Get.to(DiseasePredictorScreen());
            }),
            _buildDrawerItem(icon: Icons.account_balance, text: 'Accounts', onTap: () {
              Get.to(AccountsScreen());
            }),
            _buildDrawerItem(icon: Icons.calendar_today, text: 'Activities', onTap: () {
              Get.to(ActivitiesScreen());
            }),
            _buildDrawerItem(icon: Icons.storefront, text: 'My Store', onTap: () {
              Get.to(MyStoreScreen());
            }),
            _buildDrawerItem(icon: Icons.campaign, text: 'Ads Promotion', onTap: () {
              Get.to(AdsPromotionScreen());
            }),

            Divider(),

            // Logout
            _buildDrawerItem(icon: Icons.logout, text: 'Log Out', onTap: () {
              Get.offAll(LoginScreen()); // Log out and go to login screen
            }),
          ],
        ));
     
  }

  // Helper function to build drawer items
  Widget _buildDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon, color: Colors.orange),
      onTap: onTap,
    );
  }
}
