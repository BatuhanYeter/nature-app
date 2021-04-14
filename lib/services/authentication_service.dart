import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/widgets/exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        final UserCredential authResult =
            await auth.signInWithCredential(credential);

        final User? user = authResult.user;

        var userData = {
          'name': googleSignInAccount.displayName,
          'provider': 'google',
          'photoUrl': googleSignInAccount.photoUrl,
          'email': googleSignInAccount.email,
        };

        users.doc(user!.uid).get().then((doc) {
          if (doc.exists) {
            // old user
            doc.reference.update(userData);
            Navigator.pushNamed(context, '/home');
          } else {
            // new user
            users.doc(user.uid).set(userData);
            Navigator.pushNamed(context, '/home');
          }
        });
      }
    } catch (e) {
      print("Sign in is not successful" + e.toString());
    }
  }

  // Sign-in anonymously
  Future signInAnon(BuildContext context) async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User? user = result.user;

      if (user != null) {
        var userData = {
          'name': user.displayName,
          'provider': 'google',
          'isAnonymous': user.isAnonymous
        };

        users.doc(user.uid).get().then((doc) {
          if (doc.exists) {
            // old user
            doc.reference.update(userData);
            Navigator.pushNamed(context, '/firstScreenAR');
          } else {
            // new user
            users.doc(user.uid).set(userData);
            Navigator.pushNamed(context, '/firstScreenAR');
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  // Sign-in with email and password
  Future signIn(BuildContext context,
      {required email, required password}) async {
    try {
      // TODO: change it
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
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
        showException(context,
            message: "Wrong password provided for that user.");
        print('Wrong password provided for that user.');
      }
    }
  }

  // Sign-up with email
  Future signUp(BuildContext context,
      {required email, required password}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          var userData = {
            'name': value.user!.displayName,
            'provider': 'google',
            'email': value.user!.email,
            'emailVerified': value.user!.emailVerified,
            'photoUrl': value.user!.photoURL,
            'isAnonymous': value.user!.isAnonymous
          };

          users.doc(value.user!.uid).get().then((doc) {
            if (doc.exists) {
              // old user
              doc.reference.update(userData);
              print(value.user!.email);
              Navigator.pushNamed(context, '/firstScreenAR');
            } else {
              // new user
              print(value.user!.email);
              users.doc(value.user!.uid).set(userData);
              Navigator.pushNamed(context, '/firstScreenAR');
            }
          });

        } else {
          showException(context, message: "Something went wrong.");
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showException(context,
            message: "The account already exists for that email.");
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
      return await auth.signOut().then((value) =>
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false));
    } catch (e) {
      print(e.toString());
    }
  }

  Future emailVerification(BuildContext context) async {
    try {
      User user = auth.currentUser!;

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(BuildContext context, {required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) =>
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('An email has been sent.'))));
    } catch (e) {
      print(e.toString());
    }
  }
}
