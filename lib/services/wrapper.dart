import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/screens/home.dart';
import 'package:flutter_appp/screens/login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}
