import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/services/authentication_service.dart';
import 'package:flutter_appp/services/preferences.dart';
import 'package:flutter_appp/theme.dart';
import 'package:flutter_appp/widgets/accounts_row.dart';
import 'package:flutter_appp/widgets/notification_row.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AuthenticationService auth = AuthenticationService();
  TextEditingController emailController = TextEditingController();
  UserPreferences userPreferences = UserPreferences();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = UserPreferences.getTheme();
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            ThemeSwitcher(
              builder: (context) => IconButton(
                  icon: theme == 'dark'
                      ? Icon(Icons.wb_sunny)
                      : Icon(FontAwesomeIcons.moon),
                  onPressed: () async {
                    final String newTheme =
                        theme == 'dark' ? 'light' : 'dark';
                    UserPreferences.setTheme(newTheme);
                    final switcher = ThemeSwitcher.of(context)!;
                    switcher.changeTheme(
                        theme: newTheme == 'dark' ? darkTheme : lightTheme);
                  }),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(
              left: size.width * 0.06,
              right: size.width * 0.06,
              top: size.height * 0.03),
          child: ListView(
            children: [
              Text(
                "Settings",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.08),
              Row(
                children: [
                  Icon(FontAwesomeIcons.user),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Text(
                    "Account",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Divider(
                height: size.height * 0.03,
                thickness: size.width * 0.01,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              AccountRow(
                text: "Change Name",
                press: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              AccountRow(
                text: "Change Email",
                press: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              AccountRow(
                text: "Change Location",
                press: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              AccountRow(
                text: "Reset Password",
                press: () {
                  Navigator.pushNamed(context, '/forgotPassword');
                },
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                children: [
                  Icon(FontAwesomeIcons.bell),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Divider(
                height: size.height * 0.03,
                thickness: size.width * 0.01,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              NotificationRow(text: "Email", isActive: true),
              SizedBox(
                height: size.height * 0.01,
              ),
              NotificationRow(text: "Phone", isActive: false),
              SizedBox(
                height: size.height * 0.01,
              ),
              NotificationRow(text: "Email", isActive: true),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
