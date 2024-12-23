import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/assets.dart';
import '../Animal_Owner Menu/AccountsScreen.dart';
import '../Animal_Owner Menu/ActivitiesScreen.dart';
import '../Animal_Owner Menu/AdsPromotionScreen.dart';
import '../Animal_Owner Menu/ChatForumScreen.dart';
import '../Animal_Owner Menu/ClientsScreen.dart';
import '../Animal_Owner Menu/DiseasePredictorScreen.dart';
import '../Animal_Owner Menu/MyStoreScreen.dart';
import '../Animal_Owner Menu/feed_calculator_screen.dart';
import '../Animal_Owner Menu/home_page.dart';
import '../Animal_Owner Menu/pets_and_livestoc.dart';
import '../Vetenarian_Menu/VendorScreen.dart';
import '../../screens/login/login_view.dart';
import '../../services/users.service.dart';
import '../../dashboard/dashborad_page/dashboard_page.dart';

class VetDrawerMenu extends StatefulWidget {
  const VetDrawerMenu({super.key});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<VetDrawerMenu> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final user = Get.find<UsersService>();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Assets.imgLogin, height: 51),
                const Spacer(),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : NetworkImage(user.user.value.avatar) as ImageProvider,
                  ),
                ),
              ],
            ),
          ),

          // Drawer Items
          _buildDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Get.to(() => HomeScreen());
              }),
          _buildDrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              onTap: () {
                Get.to(() => const DashboardScreen(userDetails: {},));
              }),
          _buildDrawerItem(
              icon: Icons.pets,
              text: 'Pets & Livestocks',
              onTap: () {
                Get.to(() => PetsLivestockScreen());
              }),
          _buildDrawerItem(
              icon: Icons.people,
              text: 'Clients',
              onTap: () {
                Get.to(() => ClientsScreen());
              }),
          _buildDrawerItem(
              icon: Icons.local_hospital,
              text: 'Disease Pedictor',
              onTap: () {
                Get.to(() => Diseasepredictorscreen());
              }),
          _buildDrawerItem(
              icon: Icons.forum,
              text: 'Chat Forum',
              onTap: () {
                Get.to(() => ChatForumScreen());
              }),
          _buildDrawerItem(
              icon: Icons.store,
              text: 'Vendor',
              onTap: () {
                Get.to(() => const VendorScreen());
              }),
          _buildDrawerItem(
              icon: Icons.calculate,
              text: 'Feed Calculator',
              onTap: () {
                Get.to(() => FeedCalculatorScreen());
              }),
          _buildDrawerItem(
              icon: Icons.account_balance,
              text: 'Accounts',
              onTap: () {
                Get.to(() => const AccountsScreen());
              }),
          _buildDrawerItem(
              icon: Icons.calendar_today,
              text: 'Activities',
              onTap: () {
                Get.to(() => ActivitiesScreen());
              }),
          _buildDrawerItem(
              icon: Icons.storefront,
              text: 'My Store',
              onTap: () {
                Get.to(() => MyStoreScreen());
              }),
          _buildDrawerItem(
              icon: Icons.campaign,
              text: 'Ads Promotion',
              onTap: () {
                Get.to(() => AdsPromotionScreen());
              }),

          const Divider(),

          // Logout
          _buildDrawerItem(
              icon: Icons.logout,
              text: 'Log Out',
              onTap: () {
                Get.offAll(() => LoginScreen());
              }),
        ],
      ),
    );
  }

  // Helper function to build drawer items
  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon, color: Colors.orange),
      onTap: onTap,
    );
  }
}
