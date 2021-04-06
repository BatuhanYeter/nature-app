import 'package:flutter/material.dart';
import 'package:flutter_appp/model/user.dart';
import 'package:flutter_appp/screens/home.dart';
import 'package:flutter_appp/screens/login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pUser = Provider.of<MyUser>(context);
    if (pUser == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}
