import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/widgets/my_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
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
            Center(
              child: Stack(
                children: [
                  Container(
                    width: size.width * 0.25,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg.jpg'),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 5,
                          )
                        ]),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).bottomAppBarColor,
                          shape: BoxShape.circle),
                      height: size.height * 0.05,
                      width: size.width * 0.10,
                      child: Icon(
                        FontAwesomeIcons.pen,
                        size: size.width * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // TODO: Add the textControllers
            // TODO: Get/set the name from/to dbase
            buildTextField("Name", "Alexander Supertramp", false),
            SizedBox(
              height: size.height * 0.02,
            ),
            // TODO: Get/set the email from/to dbase
            buildTextField("Email", "Alexander@supertramp.com", false),
            SizedBox(
              height: size.height * 0.02,
            ),
            // TODO: Get/set the password from/to dbase
            buildTextField("Password", "********", true),
            SizedBox(
              height: size.height * 0.02,
            ),
            // TODO: Get/set the location from/to dbase
            buildTextField("Location", "Alaska, U.S.", false),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.06,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextField buildTextField(String labelText, String hintText, bool isPassword) {
    return TextField(
      obscureText: isPassword ? showPassword : false,
      decoration: InputDecoration(
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }
}
