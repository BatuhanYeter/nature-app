import 'package:flutter/material.dart';
import 'package:flutter_appp/widgets/accounts_row.dart';
import 'package:flutter_appp/widgets/notification_row.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
            SizedBox(height: size.height * 0.08),
            Row(
              children: [
                Icon(FontAwesomeIcons.user),
                SizedBox(width: size.width * 0.02,),
                Text("Account", style: TextStyle(fontSize: 18),),
              ],
            ),
            Divider(
              height: size.height * 0.03,
              thickness: size.width * 0.01,
            ),
            SizedBox(height: size.height * 0.02,),
            // TODO: set/get the info
            AccountRow(text: "Change Password", press: () {},),
            SizedBox(height: size.height * 0.02,),
            AccountRow(text: "Change Password", press: () {},),
            SizedBox(height: size.height * 0.02,),
            AccountRow(text: "Change Password", press: () {},),
            SizedBox(height: size.height * 0.02,),
            AccountRow(text: "Change Password", press: () {},),
            SizedBox(height: size.height * 0.04,),
            Row(
              children: [
                Icon(FontAwesomeIcons.bell),
                SizedBox(width: size.width * 0.02,),
                Text("Notifications", style: TextStyle(fontSize: 18),),
              ],
            ),
            Divider(
              height: size.height * 0.03,
              thickness: size.width * 0.01,
            ),
            SizedBox(height: size.height * 0.01,),
            NotificationRow(text: "Email", isActive: true),
            SizedBox(height: size.height * 0.01,),
            NotificationRow(text: "Phone", isActive: false),
            SizedBox(height: size.height * 0.01,),
            NotificationRow(text: "Email", isActive: true),
            SizedBox(height: size.height * 0.01,),
          ],
        ),
      ),
    );
  }
}
