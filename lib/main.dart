import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blog/blog_screen.dart';
import 'core/Animal_Owner Menu/DiseasePredictorScreen.dart';
import 'core/Animal_Owner Menu/feed_calculator_screen.dart';
import 'core/Animal_Owner Menu/messages.dart';
import 'core/Animal_Owner Menu/pets_and_livestoc.dart';
import 'dashboard/dashborad_page/dashboard_page.dart';
import 'features/onboarding_Screen.dart';
import 'core/Animal_Owner Menu/setting/about_us.dart';
import 'core/Animal_Owner Menu/setting/profile_page.dart';
import 'core/Animal_Owner Menu/setting/setting_screen.dart';
import 'config/theme.dart';
import 'screens/Animal_Proff_SignUp/proffesional_acct_screen.dart';
import 'screens/Animal_Proff_SignUp/sign_up_controller.dart';
import 'screens/User_sign_up/User_Sign_up/Basicuser_sign_up.dart';
import 'screens/User_sign_up/User_Sign_up/acivation_code.dart';
import 'screens/User_sign_up/User_Sign_up/animal_owner_createacount.dart';
import 'screens/User_sign_up/User_Sign_up/user_controller.dart';
import 'screens/login/login_view.dart';
import 'services/users.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup logging for errors to console
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  Get.put(ProffSignUpController());
  Get.put(UserTypeController());
  Get.put(UsersService());

  // Fetch the initial route based on login status
  final String initialRoute = await _getInitialRoute();

  // Run the application
  runApp(MyApp(initialRoute: initialRoute));
}

// Determines the initial route based on login state
Future<String> _getInitialRoute() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn ? '/dashboard' : '/';
  } catch (error, stackTrace) {
    print('Error fetching initial route: $error');
    print('Stack trace: $stackTrace');
    return '/'; 
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/', page: () => const Onbording()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/create-account', page: () => AnimalOwnerAccount()),
        GetPage(
          name: '/dashboard',
          page: () => const DashboardScreen(userDetails: {}),
        ),
        GetPage(name: '/Messages', page: () => MessageScreen()),
        GetPage(name: '/blog', page: () => BlogPage()),
        GetPage(name: '/feed_calculator', page: () => FeedCalculatorScreen()),
        GetPage(name: '/settings', page: () => const SettingScreen()),
        GetPage(
          name: '/profile',
          page: () => UserProfilePage(userDetails: const {}),
        ),
        GetPage(name: '/about', page: () => const AboutPage()),
        GetPage(name: '/Pets-livestock', page: () => PetsLivestockScreen()),
        GetPage(name: '/signUp', page: () => BasicUserSignUp()),
        GetPage(name: '/Vet-account', page: () => const VetCreateAcctScreen()),
        GetPage(name: '/disease-predictor', page: () => Diseasepredictorscreen()),
        GetPage(
          name: '/activation-code',
          page: () => const ActivationCode(),
        ),
      ],
    );
  }
}
