import 'package:chat_app/constans.dart';
import 'package:chat_app/helper/show_snakbar.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  static const String registerPageId = "registerpage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = "";

  String password = "";

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        resizeToAvoidBottomInset: true,
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
                      text: "Register",
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
                    text: "Register",
                    color: Colors.blue,
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await Register_User();
                          ShowsnakBar(context, "User Registered Successfully");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ShowsnakBar(
                              context,
                              'The password provided is too weak.',
                            );
                          } else if (e.code == 'email-already-in-use') {
                            ShowsnakBar(
                              context,
                              'The account already exists for that email.',
                            );
                          } else if (e.code == 'network-request-failed') {
                            ShowsnakBar(
                              context,
                              'Check your internet connection',
                            );
                          }
                        } catch (e) {
                          ShowsnakBar(context, e.toString());
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        ShowsnakBar(context, "Please fill all fields");
                      }
                    },
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Already have an account? ",
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomText(
                          text: "Login",
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

  Future<void> Register_User() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
