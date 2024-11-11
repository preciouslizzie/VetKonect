import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:vet_konect/network%20folder/api_services.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var rememberMe = false.obs;
  var emailError = ''.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  Dio dio = Dio();
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

  Future<void> saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
    if (value) {
      await prefs.setString('savedEmail', email.value);
      await prefs.setString('savedPassword', password.value);
    } else {
      await prefs.remove('savedEmail');
      await prefs.remove('savedPassword');
    }
  }

  Future<bool?> loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe');
  }

  void prefillEmailAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email.value = prefs.getString('savedEmail') ?? '';
    password.value = prefs.getString('savedPassword') ?? '';
  }

  // LinkedIn Login
  Future<void> loginWithLinkedIn() async {
    const String clientId = '';
    const String clientSecret = '';
    const String redirectUri = '';
    const String authUrl = 'https://www.linkedin.com/oauth/v2/authorization';
    const String tokenUrl =
        'https://vetkonect.com/backend/public/api/linkedin/loginUsingLinkedin';

    final authUri = Uri.parse(
      '$authUrl?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=r_liteprofile%20r_emailaddress',
    );

    final flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.launch(
      authUri.toString(),
      clearCookies: true,
      clearCache: true,
    );

    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (url.startsWith(redirectUri)) {
        flutterWebviewPlugin.close();

        final code = Uri.parse(url).queryParameters['code'];
        if (code != null) {
          await _fetchLinkedInAccessToken(
            code,
            clientId,
            clientSecret,
            redirectUri,
            tokenUrl,
          );
        } else {
          Get.snackbar('Error', 'LinkedIn login failed');
        }
      }
    });
  }

  Future<void> _fetchLinkedInAccessToken(String code, String clientId,
      String clientSecret, String redirectUri, String tokenUrl) async {
    isLoading(true);

    try {
      final response = await dio.post(tokenUrl, data: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
        'client_id': clientId,
        'client_secret': clientSecret,
      });

      if (response.statusCode == 200 && response.data != null) {
        Get.snackbar('Success', 'LinkedIn login successful');
      } else {
        Get.snackbar('Error', 'Failed to complete LinkedIn login');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong with LinkedIn login');
      print('LinkedIn login error: $e');
    } finally {
      isLoading(false);
    }
  }

  // login method in use
  Future<void> loginFunction() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty.');
      return;
    }
    isLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      var response = await ApiService().post(
          'https://vetkonect.com/backend/public/api/web/v2/login',
          {"email": email.value, "password": password.value},
          Client(),
          "");
      var data = json.decode(response.body);
      if (data['code'] == 200) {
        Get.snackbar('Success', 'Login Successful');
        Get.offAllNamed('/dashboard');
      } else {
        emailError.value = data['message'] ?? 'Login failed, Please try again';
      }
      successMessage.value =
          'Password reset link has been sent to ${email.value}';
    } catch (e) {
      errorMessage.value =
          'Failed to send password reset link, please try again';
      emailError.value = 'Network Error, Check your connection and try again';
      print('Login Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Facebook Login
  Future<void> loginWithFacebook() async {
    isLoading(true);
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        await socialLogin('facebook');
      } else {
        Get.snackbar('Error', 'Facebook login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong with Facebook login');
      print('Facebook login error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Google Login
  Future<void> loginWithGoogle() async {
    isLoading(true);
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        await socialLoginWithGoogle();
      } else {
        Get.snackbar('Error', 'Google login cancelled');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong with Google login');
      print('Google login error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Apple Login
  Future<void> loginWithApple() async {
    isLoading(true);
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      if (credential.identityToken != null) {
        await socialLogin('apple');
      } else {
        Get.snackbar('Error', 'Apple login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong with Apple login');
      print('Apple login error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> socialLoginWithGoogle() async {
    isLoading(true);
    try {
      var response = await dio.post(
        'https://vetkonect.com/backend/public/api/google/loginUsingGoogle',
        data: {
          'provider': 'google',
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Login Successful');
        Get.offAllNamed('/dashboard');
      } else {
        final message = response.data['message'] ?? 'Google login failed';
        Get.snackbar('Error', message);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong with Google login');
      print('Google login error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Generic Social Login for other providers
  Future<void> socialLogin(String provider) async {
    isLoading(true);
    try {
      var response = await dio.post('/social-login', data: {
        'provider': provider,
      });

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Login Successful');
        Get.offAllNamed('/dashboard');
      } else {
        final message = response.data['message'] ?? 'Social login failed';
        Get.snackbar('Error', message);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong with social login');
      print('Social login error: $e');
    } finally {
      isLoading(false);
    }
  }
}
