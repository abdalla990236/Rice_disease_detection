import 'package:flutter/material.dart';
import 'package:chatapp/modules/Login/LoginScreen.dart';

class NavigationUtils {
  static Future<void> navigateToSecondRoute(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
