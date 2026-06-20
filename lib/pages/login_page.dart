import 'package:chat_app/constans.dart';
import 'package:chat_app/helper/show_snakbar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  static const String loginPageId = "loginpage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

String email = "";
String password = "";

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, top: 120),
              child: Column(
                children: [
                  SizedBox(height: 20),

                  Image.asset('assets/images/scholar.png'),

                  CustomText(
                    text: "Scholar Chat",
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: "pacifico",
                  ),

                  SizedBox(height: 40),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Login",
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),

                  const SizedBox(height: 15),

                  CustomFromTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!value.contains("@gmail.com")) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    hintText: "Enter your email",
                    input: TextInputType.emailAddress,
                    obscureText: false,
                  ),

                  const SizedBox(height: 20),

                  CustomFromTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters and provide a strong password";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    hintText: "Enter your password",
                    input: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),

                  CustomButton(
                    text: "Login",
                    color: Colors.blue,
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await login();
                          Navigator.pushNamed(
                            context,
                            ChatPage.chatPageId,
                            arguments: email,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ShowsnakBar(
                              context,
                              "No user found for that email.",
                            );
                          } else if (e.code == 'wrong-password') {
                            ShowsnakBar(
                              context,
                              "Wrong password provided for that user.",
                            );
                          } else if (e.code == 'invalid-email') {
                            ShowsnakBar(
                              context,
                              "The email address is badly formatted.",
                            );
                          } else if (e.code == 'user-disabled') {
                            ShowsnakBar(
                              context,
                              "The user account has been disabled by an administrator.",
                            );
                          } else if (e.code == 'too-many-requests') {
                            ShowsnakBar(
                              context,
                              "Too many requests. Try again later.",
                            );
                          } else if (e.code == 'operation-not-allowed') {
                            ShowsnakBar(
                              context,
                              "Email/password accounts are not enabled.",
                            );
                          } else {
                            ShowsnakBar(
                              context,
                              "An undefined Error happened.",
                            );
                          }
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    },
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Don't have an account? ",
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RegisterPage.registerPageId,
                          );
                        },
                        child: CustomText(
                          text: "Register",
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> login() async {
  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
}
