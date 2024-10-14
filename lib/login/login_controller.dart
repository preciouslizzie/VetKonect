import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var rememberMe = false.obs;

  Dio dio = Dio(BaseOptions(baseUrl: 'https://your-laravel-backend.com/api'));

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    if (box.read('rememberMe') ?? false) {
      email.value = box.read('email') ?? '';
      password.value = box.read('password') ?? '';
      rememberMe.value = true;
    }
  }

  void login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty.');
      return;
    }

    Get.offAllNamed('/dashboard');

    return;


    isLoading(true);

    try {
      Response response = await dio.post('/login', data: {
        'email': email.value,
        'password': password.value,
      });

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Login Successful');
        Get.offAllNamed('/dashboard');

        if (rememberMe.value) {
          box.write('email', email.value);
          box.write('password', password.value);
          box.write('rememberMe', true);
        } else {
          box.remove('email');
          box.remove('password');
          box.write('rememberMe', false);
        }
      } else {
        Get.snackbar('Error', 'Invalid credentials');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');

      print('error start here');
      print('');
      print(e);
    } finally {
      isLoading(false);
    }
  }
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void forgetPassword() {
    Get.toNamed('/forget-password');
  }

  Future<void> loginWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        await socialLogin('google', googleAuth.accessToken!);
      } else {
        Get.snackbar('Error', 'Google login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong with Google login');
    }
  }

  Future<void> loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );
      await socialLogin('apple', credential.identityToken!);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong with Apple login');
    }
  }

  Future<void> socialLogin(String provider, String token) async {
    isLoading(true);

    try {
      Response response = await dio.post('/social-login', data: {
        'provider': provider,
        'token': token,
      });

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Login Successful');
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar('Error', 'Social login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong with social login');
    } finally {
      isLoading(false);
    }
  }
}
