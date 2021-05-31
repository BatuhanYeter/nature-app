import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_appp/blocs/add_comment.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:flutter_appp/screens/add_friend.dart';
import 'package:flutter_appp/screens/current_user_events.dart';
import 'package:flutter_appp/screens/edit_event.dart';
import 'package:flutter_appp/screens/after_register/first_screen_ar.dart';
import 'package:flutter_appp/screens/after_register/second_screen_ar.dart';
import 'package:flutter_appp/screens/after_register/third_screen_ar.dart';
import 'package:flutter_appp/screens/forgot_password.dart';
import 'package:flutter_appp/screens/home.dart';
import 'package:flutter_appp/screens/home_tabs/home_body.dart';
import 'package:flutter_appp/screens/login.dart';
import 'package:flutter_appp/screens/friend_requests.dart';
import 'package:flutter_appp/screens/user_map.dart';
import 'package:flutter_appp/screens/profile.dart';
import 'package:flutter_appp/screens/settings.dart';
import 'package:flutter_appp/screens/sign_up.dart';
import 'package:flutter_appp/services/authentication_service.dart';
import 'package:flutter_appp/services/event_provider.dart';
import 'package:flutter_appp/services/preferences.dart';
import 'package:flutter_appp/services/wrapper.dart';
import 'package:flutter_appp/theme.dart';
import 'package:provider/provider.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

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
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().auth.authStateChanges(),
            initialData: null,
          ),
          ChangeNotifierProvider(
            create: (context) => ApplicationBloc(),
            child: UserMap(),
          ),
          ChangeNotifierProvider(
            create: (context) => EventProvider(),
            child: EditEvent(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddComment(),
            child: HomeBody(),
          ),
        ],
        child: ThemeProvider(
            initTheme:
                UserPreferences.getTheme() == 'dark' ? darkTheme : lightTheme,
            child: Builder(
              builder: (context) => MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                theme: ThemeProvider.of(context),
                //darkTheme: darkTheme,
                //themeMode: ThemeMode.system,
                // by default, gets the theme from system
                routes: {
                  '/': (context) => Wrapper(),
                  '/login': (context) => LoginPage(),
                  '/forgotPassword': (context) => ForgotPassword(),
                  '/signUp': (context) => SignUp(),
                  '/home': (context) => HomePage(),
                  '/profile': (context) => Profile(),
                  '/settings': (context) => Settings(),
                  '/firstScreenAR': (context) => FirstScreenAR(),
                  '/secondScreenAR': (context) => SecondScreenAR(),
                  '/thirdScreenAR': (context) => ThirdScreenAR(),
                  '/maps': (context) => UserMap(),
                  '/addEvent': (context) => EditEvent(),
                  '/myEvents': (context) => CurrentUserEvents(),
                  '/friendRequest': (context) => FriendRequestScreen(),
                  '/addFriend': (context) => AddFriend()
                },
              ),
            )));
  }
}
