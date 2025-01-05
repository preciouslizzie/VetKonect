import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../config/theme.dart';
import '../../../features/customscaffold.dart';
import 'user_controller.dart';

class BasicUserSignUp extends StatefulWidget {
  final UserTypeController signUpController = Get.put(UserTypeController());
  final RxBool isPasswordVisible = false.obs;

  BasicUserSignUp({super.key});

  @override
  State<BasicUserSignUp> createState() => _BasicUserSignUpState();
}

class _BasicUserSignUpState extends State<BasicUserSignUp> {
  final _formSignInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0),

                      // Email Field
                      TextFormField(
                        onChanged: (value) =>
                            widget.signUpController.email.value = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          if (!RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
                              .hasMatch(value)) {
                            return 'Invalid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Enter Email',
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),

                      // Password Field
                      Obx(
                        () => TextFormField(
                          obscureText: !widget.isPasswordVisible.value,
                          obscuringCharacter: '*',
                          onChanged: (value) =>
                              widget.signUpController.password.value = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(color: Colors.black26),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(31, 238, 87, 87),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
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
                        ),
                      ),
                      const SizedBox(height: 25.0),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: Obx(
                          () => widget.signUpController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (_formSignInKey.currentState!
                                        .validate()) {
                                      await widget.signUpController
                                          .registerAnimalOwnerStageOne();

                                      if (!widget.signUpController.isLoading
                                          .value) {
                                        Get.toNamed("/create-account");
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 25.0),

                      // Divider
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
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'or Sign up with',
                              style: TextStyle(color: Colors.black45),
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

                      const SizedBox(height: 25.0),

                      // Social Media Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.snackbar('Coming Soon', 'Login with Facebook');
                            },
                            icon: const Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                              size: 35.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.snackbar('Coming Soon', 'Login with Google');
                            },
                            icon: const Icon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                              size: 35.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.snackbar(
                                  'Coming Soon', 'Login with LinkedIn');
                            },
                            icon: const Icon(
                              FontAwesomeIcons.linkedin,
                              color: Color.fromARGB(255, 1, 82, 147),
                              size: 35.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.snackbar('Coming Soon', 'Login with Apple');
                            },
                            icon: const Icon(
                              FontAwesomeIcons.apple,
                              color: Colors.black,
                              size: 35.0,
                            ),
                          ),
                        ],
                      ),
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
