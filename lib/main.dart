import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/Drawer/drawer%20Menu/Pets%20and%20livestock/PetsLivestockScreen.dart';
import 'package:vet_konect/dashboard/dashborad_page/dashboard_page.dart';
import 'package:vet_konect/login/login.dart';
import 'package:vet_konect/services/users.service.dart';
import 'package:vet_konect/sign_up/create_account%20_screen.dart';
import 'package:vet_konect/sign_up/sign_up_controller.dart';
import 'blog/blog_screen.dart';
import 'feed_calculator/feed_calculator_screen.dart';
import 'login/onboarding_Screen.dart';
import 'Dasboard_Search/search/search_screen.dart';
import 'setting/about_us.dart';
import 'setting/profile_page.dart';
import 'setting/setting_screen.dart';
import 'theme/theme.dart';

void main() {
  Get.put(SignUpController());

  Get.put(UsersService());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Onbording()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/create-account', page: () => CreateAccountScreen()),
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
        GetPage(name: '/search', page: () => SearchScreen()),
        GetPage(name: '/blog', page: () => BlogPage()),
        GetPage(name: '/feed_calculator', page: () => FeedCalculatorScreen()),
        GetPage(name: '/settings', page: () => SettingScreen()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/about', page: () => AboutPage()),
        GetPage(name: '/Pets-livestock', page: () => PetsLivestockScreen())
      ],
    );
  }
}
