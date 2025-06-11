import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatapp/modules/Login/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/modules/Login/HomeScreen.dart';
import 'package:chatapp/modules/Login/RegisterScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../Chat_Screen/ChatScreen.dart';
import '../../shared/components/components.dart';

import '../../shared/components/constants.dart';
import '../../shared/components/small_widgets.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Top Background Image
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/field.jpg'), // Add your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 100),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                width: 320,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.deepPurple),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text("Login", style: TextStyle(color: Colors.deepPurple)),
                      ),
                      SizedBox(height: 20),
                      defualtTextField(
                        controller: emailController,
                        lable: "Email or Username",
                        prefix: Icons.email,
                        validate: (val) => val!.isEmpty ? 'Required' : null, type: TextInputType.emailAddress, onTap: () {  },
                      ),
                      SizedBox(height: 15),
                      defualtTextField(
                        controller: passController,
                        lable: "Password",
                        prefix: Icons.lock,
                        sufix: Icons.remove_red_eye_outlined,
                        obsecure: true,
                        validate: (val) => val!.isEmpty ? 'Required' : null, onTap: () {  }, type: TextInputType.visiblePassword,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Forget Password?", style: TextStyle(color: Colors.grey[600])),
                        ),
                      ),
                      defualtButton(
                          function: () async {
                            /*if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${emailController.text} ${passController.text}'),
                        ));
                      }*/
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              try {
                                await loginUser();

                                Navigator.pushNamed(context, OnboardingScreen.id,
                                    arguments: emailController.text);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  showSnackBar(context, "No user found for that email.");
                                } else if (e.code == 'wrong-password') {
                                  showSnackBar(context, "Wrong password provided for that user.");
                                } else {
                                  showSnackBar(context, "Error: ${e.message}");
                                }
                              }

                              isLoading = false;
                              // showSnackBar(context, "Successfully");
                            } else {}
                          },
                          text: 'Login'), //Btn
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Don\'t have an acount?',
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          defualtTextButton(
                            text: 'Register',
                            function: () {
                              Navigator.pushNamed(context, RegisterScreen.id);
                            },
                            isBold: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("or", style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/icons/facebook.png', height: 40),
                          Image.asset('assets/icons/twitter.png', height: 40),
                          Image.asset('assets/icons/google.png', height: 40),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );
  }
}
