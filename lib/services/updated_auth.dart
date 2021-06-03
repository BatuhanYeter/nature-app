import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/screens/home.dart';
import 'package:flutter_appp/services/database.dart';
import 'package:flutter_appp/services/preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
        (await _googleSignIn.signIn())!;

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);

    User userDetails = result.user!;

    UserPreferences().saveUserEmail(userDetails.email!);
    UserPreferences().saveUserId(userDetails.uid);
    UserPreferences().saveDisplayName(userDetails.displayName!);
    UserPreferences().saveUserProfileUrl(userDetails.photoURL!);
    UserPreferences()..saveUserName(userDetails.email!.replaceAll("@gmail.com", ""));
    // in firestore, all the keys (name, email, etc) are
    // strings but the data might be different. So it is dynamic.
    Map<String, dynamic> userInfoMap = {
      "email": userDetails.email,
      "username": userDetails.email!.replaceAll("@gmail.com", ""),
      "name": userDetails.displayName,
      "photoUrl": userDetails.photoURL
    };

    DatabaseMethods()
        .addUserInfoToDb(userDetails.uid, userInfoMap)
        .then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  Future signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await auth.signOut().then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', (route) => false));;

  }
}
