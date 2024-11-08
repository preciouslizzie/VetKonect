import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vet_konect/features/customscaffold.dart';
import 'package:vet_konect/sign_up/Animal_Proff_SignUp/sign_up_controller.dart';
import 'package:vet_konect/config/theme.dart';

class ProffBasicSignUp extends StatefulWidget {
  final ProffSignUpController signUpController = Get.put(ProffSignUpController());
  final RxBool isPasswordVisible = false.obs;

  @override
  State<ProffBasicSignUp> createState() => _ProffBasicSignUp();
}

class _ProffBasicSignUp extends State<ProffBasicSignUp> {
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
            flex: 5,
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
                      TextFormField(
                        onChanged: (value) => widget.signUpController.email.value = value,
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
                      Obx(
                        () => TextFormField(
                          obscureText: !widget.isPasswordVisible.value,
                          obscuringCharacter: '*',
                          onChanged: (value) => widget.signUpController.password.value = value,
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
                              borderSide: const BorderSide(
                                color: Color.fromARGB(31, 238, 87, 87),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                widget.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                widget.isPasswordVisible.value = !widget.isPasswordVisible.value;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      SizedBox(
                        width: double.infinity,
                        child: Obx(
                          () => widget.signUpController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () {
                                    if (_formSignInKey.currentState!.validate()) {
                                      widget.signUpController.signUp;
                                      Get.toNamed("/Vet-account");
                                    }
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ),
                        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Logo(Logos.google),
                            onPressed: () async {
                              await widget.signUpController.loginWithGoogle();
                            },
                          ),
                          IconButton(
                            icon: Logo(Logos.linkedin),
                            onPressed: () async {
                              await widget.signUpController.loginWithLinkedIn();
                            },
                          ),
                          // IconButton(
                          //   icon: Logo(Logos.facebook_f),
                          //   onPressed: () async {
                          //     await widget.signUpController.loginWithFacebook();
                          //   },
                          // ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
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
