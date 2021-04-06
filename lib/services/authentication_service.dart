import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/model/user.dart';
import 'package:flutter_appp/screens/home.dart';
import 'package:flutter_appp/widgets/exception.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  MyUser? createMyUserObjectFromUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // Every time a user sign-in or out, it will give a response down the stream
  Stream<MyUser?> get pUser {
    return auth.userChanges().map(createMyUserObjectFromUser);
  }

  // Sign-in anonymously
  Future signInAnon(BuildContext context) async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User? user = result.user;

      return createMyUserObjectFromUser(user);
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  // Sign-in with email and password
  Future signIn(BuildContext context, {required email, required password}) async {
    try {
      // TODO: change it
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if(user != null) {
        createMyUserObjectFromUser(user);
        // TODO: email verify check user.emailVerified
        Navigator.pushNamed(context, '/home');
      } else {
        showException(context, message: "Something went wrong.");
      }

      // return createMyUserObjectFromUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showException(context, message: "No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showException(context, message: "Wrong password provided for that user.");
        print('Wrong password provided for that user.');
      }
    }
  }

  // Sign-up with email
  Future signUp(BuildContext context, {required email, required password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password).then((value) {
            if(value.user != null) {
              createMyUserObjectFromUser(value.user);
              Navigator.pushNamed(context, '/home');
            } else {
              showException(context, message: "Something went wrong.");
            }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showException(context, message: "The account already exists for that email.");
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign-out
  Future signOut(BuildContext context) async {
    try {
      return await auth.signOut().then((value) => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false));
    } catch (e) {
      return null;
    }
  }

  Future emailVerification(BuildContext context) async {
    try {
      User user = auth.currentUser!;

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      return null;
    }
  }
}
