/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  void _loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('remember_me') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('email') ?? '';
      }
    });
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    var response = await http.post(
      Uri.parse('https://your-laravel-backend.com/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Success logic here (Save token or navigate)
      if (_rememberMe) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('remember_me', true);
        await prefs.setString('email', email);
      }
      // Navigate to home screen or next screen
    } else {
      // Handle login error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid email or password'),
        ),
      );
    }
  }

  Future<void> _loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account != null) {
      final GoogleSignInAuthentication auth = await account.authentication;
      var response = await http.post(
        Uri.parse('https://your-laravel-backend.com/api/social-login'),
        body: {
          'provider': 'google',
          'token': auth.accessToken,
        },
      );
      // Handle response logic here
    }
  }

  Future<void> _loginWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    var response = await http.post(
      Uri.parse('https://your-laravel-backend.com/api/social-login'),
      body: {
        'provider': 'apple',
        'token': credential.identityToken,
      },
    );
    // Handle response logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                ),
                Text('Remember me'),
              
                TextButton(
                  onPressed: () {
                    // Navigate to forget password page
                  },
                  child: Text('Forget password?'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            Divider(),
            Text('Sign up with'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: _loginWithGoogle,
                ),
                IconButton(
                  icon: Icon(Icons.apple),
                  onPressed: _loginWithApple,
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                // Navigate to Sign up page
              },
              child: Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}*/
