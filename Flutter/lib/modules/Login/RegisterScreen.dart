import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/modules/Login/LoginScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../main.dart';
import '../../shared/components/components.dart';

import '../../shared/components/constants.dart';
import '../../shared/components/small_widgets.dart';
class RegisterScreen extends StatefulWidget {
  static String id = "RegisterScreen";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  image: AssetImage('assets/images/field.jpg'),
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text("Register",
                            style: TextStyle(color: Colors.deepPurple)),
                      ),
                      SizedBox(height: 20),
                      defualtTextField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) =>
                        value!.isEmpty ? 'Required Email' : null,
                        onTap: () {},
                        lable: 'Email',
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(height: 15),
                      defualtTextField(
                        controller: passController,
                        type: TextInputType.visiblePassword,
                        validate: (value) =>
                        value!.isEmpty ? 'Required Password' : null,
                        onTap: () {},
                        lable: 'Password',
                        prefix: Icons.lock,
                        sufix: Icons.remove_red_eye_outlined,
                        obsecure: true,
                      ),
                      SizedBox(height: 15),
                      defualtButton(
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() => isLoading = true);
                              try {
                                await registerUser();
                                Navigator.pop(context);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showSnackBar(context,
                                      "The password provided is too weak.");
                                } else if (e.code == 'email-already-in-use') {
                                  showSnackBar(context,
                                      "The account already exists for that email.");
                                }
                              }
                              setState(() => isLoading = false);
                            }
                          },
                          text: 'Register'),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'I have an account?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          defualtTextButton(
                            text: 'Login',
                            function: () {
                              Navigator.pop(context);
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

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );
  }
}
