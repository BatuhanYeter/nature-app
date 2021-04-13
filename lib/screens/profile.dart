import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  String name = '';
  String email = '';
  String photoUrl = '';
  String location = '';
  // TODO: This will lead to settings page to update user data
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.cog),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data()!;
            return Container(
              padding: EdgeInsets.only(
                  left: size.width * 0.06,
                  right: size.width * 0.06,
                  top: size.height * 0.03),
              child: ListView(
                children: [
                  Text(
                    "Profile",
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
                                  color:
                                  Theme.of(context).scaffoldBackgroundColor),
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
                          bottom: 15,
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
                  buildTextField("Name", data['name'], false, nameController, name),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  // TODO: Get/set the email from/to dbase
                  buildTextField("Email", data['email'], false,
                      emailController, email),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  // TODO: Get/set the password from/to dbase
                  /* buildTextField("Password", "********", true),
              SizedBox(
                height: size.height * 0.02,
              ),*/
                  // TODO: Get/set the location from/to dbase
                  buildTextField("Location", "Alaska, U.S.", false,
                      locationController, location),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
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
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () async {
                          print('a');
                          /*
                          users
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                                'name': nameController.text.trim(),
                                'email': emailController.text.trim()
                              })
                              .then((value) => print("User Updated"))
                              .catchError((error) =>
                                  print("Failed to update user: $error")); */
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }


   TextField buildTextField(String labelText, String hintText, bool isPassword,
       TextEditingController controller, String aimText) {
     return TextField(
       onChanged: (_val) {
         aimText = _val;
       },
       controller: controller,
       decoration: InputDecoration(
           contentPadding: EdgeInsets.only(bottom: 3),
           labelText: labelText,
           hintText: hintText,
           hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
           floatingLabelBehavior: FloatingLabelBehavior.always),
     );
   }
}
