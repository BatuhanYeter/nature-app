import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_appp/model/user.dart';
import 'package:flutter_appp/screens/after_register/first_screen_ar.dart';
import 'package:flutter_appp/screens/after_register/second_screen_ar.dart';
import 'package:flutter_appp/screens/after_register/third_screen_ar.dart';
import 'package:flutter_appp/screens/forgot_password.dart';
import 'package:flutter_appp/screens/home.dart';
import 'package:flutter_appp/screens/login.dart';
import 'package:flutter_appp/screens/settings.dart';
import 'package:flutter_appp/screens/sign_up.dart';
import 'package:flutter_appp/services/authentication_service.dart';
import 'package:flutter_appp/services/preferences.dart';
import 'package:flutter_appp/services/wrapper.dart';
import 'package:flutter_appp/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // FlutterFire and Firebase need to be initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await UserPreferences.init();

  String theme = UserPreferences.getTheme() ?? "dark";
  runApp(MyApp(
    theme: theme,
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.theme}) : super(key: key);
  final String theme;

  @override
  Widget build(BuildContext context) {
    // Providers
    return MultiProvider(
        providers: [
          StreamProvider<MyUser?>.value(
            initialData: null,
            value: AuthenticationService().pUser,
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          theme: theme == "dark" ? darkTheme : lightTheme,
          //darkTheme: darkTheme,
          //themeMode: ThemeMode.system,
          // by default, gets the theme from system
          routes: {
            '/': (context) => Wrapper(),
            '/login': (context) => LoginPage(),
            '/forgotPassword': (context) => ForgotPassword(),
            '/signUp': (context) => SignUp(),
            '/home': (context) => HomePage(),
            '/settings': (context) => Settings(),
            '/firstScreenAR': (context) => FirstScreenAR(),
            '/secondScreenAR': (context) => SecondScreenAR(),
            '/thirdScreenAR': (context) => ThirdScreenAR(),


          },
        ));
  }
}
