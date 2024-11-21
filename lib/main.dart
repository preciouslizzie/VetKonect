import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/core/Animal_Owner%20Menu/DiseasePredictorScreen.dart';
 import 'package:vet_konect/core/Animal_Owner%20Menu/pets_and_livestoc.dart';
import 'package:vet_konect/dashboard/dashborad_page/dashboard_page.dart';
import 'package:vet_konect/feed_calculator/services/users.service.dart';
import 'package:vet_konect/screens/Animal_Proff_SignUp/sign_up_controller.dart';
import 'package:vet_konect/screens/Animal_Proff_SignUp/proffesional_screen.dart';
import 'package:vet_konect/screens/login/login_view.dart';
import 'package:vet_konect/screens/sign_up/User_Sign_up/Basicuser_sign_up.dart';
import 'package:vet_konect/screens/sign_up/User_Sign_up/animal_owner_createacount.dart';
import 'package:vet_konect/screens/sign_up/User_Sign_up/user_controller.dart';
import 'blog/blog_screen.dart';
import 'feed_calculator/feed_calculator_screen.dart';
import 'features/onboarding_Screen.dart';
import 'Dasboard_Search/search/search_screen.dart';
import 'core/Animal_Owner Menu/setting/about_us.dart';
import 'core/Animal_Owner Menu/setting/profile_page.dart';
import 'core/Animal_Owner Menu/setting/setting_screen.dart';
import 'config/theme.dart';

void main() {
  Get.put(ProffSignUpController());
  Get.put(UserTypeController());

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
        GetPage(name: '/create-account', page: () => AnimalOwnerAccount()),
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
        GetPage(name: '/search', page: () => SearchScreen()),
        GetPage(name: '/blog', page: () => BlogPage()),
        GetPage(name: '/feed_calculator', page: () => FeedCalculatorScreen()),
        GetPage(name: '/settings', page: () => SettingScreen()),
        GetPage(
            name: '/profile',
            page: () => UserProfilePage(
                firstName: '',
                lastName: '',
                phone: '',
                address: '',
                category: '',
                country: '')),
        GetPage(name: '/about', page: () => AboutPage()),
         GetPage(name: '/Pets-livestock', page: () => PetsLivestockScreen()),
        GetPage(name: '/signUp', page: () => BasicUserSignUp()),
        GetPage(name: '/Vet-account', page: () => VetCreateAcctScreen()),
        GetPage(name: '/disease-prdictor', page: () => DiseasePredictorScreen())
      ],
    );
  }
}
