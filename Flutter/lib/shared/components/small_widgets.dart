import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chatapp/modules/Login/LoginScreen.dart';
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black), // black text
      ),
      backgroundColor: Colors.grey[300], // light gray background
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
    ),
  );
}
void navigateToSecondRoute(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}

typedef ControllerCallback = void Function(TextEditingController);

Widget defaultTextField2({
  double width = double.infinity,
  double height = 45.0,
  ControllerCallback? controllerCallback,
  required TextInputType type,
  required FormFieldValidator validate,
  required String label,
  Function(String)? onSubmitted,
  bool enableClick = true,
  Color color = Colors.grey,
  double radius = 0.0,
  IconData? prefix,
  IconData? suffix,
}) {
  TextEditingController controller = TextEditingController();

  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        suffixIcon: Icon(
          suffix,
          color: Colors.white70,
        ),
      ),
      onSubmitted: onSubmitted,
      enabled: enableClick,
    ),
  );
}

Widget withBorder(Widget child) {
  return DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    ),
  );
}
