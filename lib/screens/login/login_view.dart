import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../config/theme.dart';
import '../../features/customscaffold.dart';
import '../User_sign_up/sign_up.dart';
import 'forget_password_screen.dart';
import 'login_controller.dart';
import 'social_media_controller.dart';

class LoginScreen extends StatefulWidget {
  final LoginController loginController = Get.put(LoginController());
  final RxBool isPasswordVisible = false.obs;
  final SocialMediaController socialMediaController = Get.put(SocialMediaController());
  

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  final RxBool rememberMe = false.obs;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    bool? storedRememberMe = await widget.loginController.loadRememberMe();
    rememberMe.value = storedRememberMe ?? true;

    if (rememberMe.value) {
      widget.loginController.prefillEmailAndPassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    var socialMediaController;
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(height: 10),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0),

                      // Email Field
                      Obx(() => TextFormField(
                            initialValue: widget.loginController.email.value,
                            onChanged: (value) =>
                                widget.loginController.email.value = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Email'),
                              hintText: 'Enter Email',
                              hintStyle: const TextStyle(color: Colors.black26),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )),
                      const SizedBox(height: 25.0),

                      // Password Field
                      Obx(() => TextFormField(
                            initialValue: widget.loginController.password.value,
                            obscureText: !widget.isPasswordVisible.value,
                            onChanged: (value) =>
                                widget.loginController.password.value = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Password'),
                              hintText: 'Enter Password',
                              hintStyle: const TextStyle(color: Colors.black26),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  widget.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  widget.isPasswordVisible.value =
                                      !widget.isPasswordVisible.value;
                                },
                              ),
                            ),
                          )),
                      const SizedBox(height: 10.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() => Checkbox(
                                    value: rememberMe.value,
                                    onChanged: (value) {
                                      rememberMe.value = value ?? false;
                                      widget.loginController
                                          .saveRememberMe(rememberMe.value);
                                    },
                                  )),
                              const Text('Remember me'),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(()=> ForgetPasswordScreen());

                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() => widget.loginController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: () {
                                  if (_formSignInKey.currentState!.validate()) {
                                    widget.loginController.loginFunction();
                                  }                                  
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )),
                      ),
                      const SizedBox(height: 25.0),

                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Or Login With',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => socialMediaController.loginWithFacebook(), 
                          icon: const Icon(
                            FontAwesomeIcons.facebook, 
                            color: Colors.blue,
                            size: 35.0,)),
                            IconButton(
                            onPressed: () => socialMediaController.loginWitGoogle(), 
                          icon: const Icon(
                            FontAwesomeIcons.google, 
                            color: Colors.red,
                            size: 35.0,)),
                            IconButton(
                            onPressed: () => socialMediaController.loginWithLinkedIn(), 
                          icon: const Icon(
                            FontAwesomeIcons.linkedin, 
                            color:Color.fromARGB(255, 1, 82, 147),
                            size: 35.0,)),
                            IconButton(
                            onPressed: () => socialMediaController.loginWithApple(), 
                          icon: const Icon(
                            FontAwesomeIcons.apple, 
                            color: Colors.black,
                            size: 35.0,))
                        ],                      ),
                       const SizedBox(height: 25.0),

                      // Sign Up Option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(color: Colors.black45),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


