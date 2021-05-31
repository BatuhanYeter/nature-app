import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SocialService {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future friendRequest(BuildContext context, {required String email}) async {
    try {
      User user = auth.currentUser!;

      var addedFriendId = '';
      var addedFriendName = '';

      var senderData = {
        'id': user.uid,
        'email': user.email,
        'name': user.displayName,
        'isAccepted': false
      };
      users.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['email'] == email) {
            addedFriendId = doc.id;
            addedFriendName = doc['name'];
            users.doc(addedFriendId).collection('friends').doc(user.uid).set(senderData);
            var friendData = {
              'id': addedFriendId,
              'email': email,
              'name': addedFriendName,
              'isAccepted': false
            };

            users.doc(user.uid).collection('friends').doc(addedFriendId).set(friendData).then((value) =>
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('An email has been sent.'))));
          }
        });
      });


    } catch (e) {
      print(e.toString());
    }
  }

  Future acceptRequest(String email) async {
    try {
      User user = auth.currentUser!;

      users.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['email'] == email) {
            users.doc(user.uid).collection('friends').doc(doc.id).update({'isAccepted': true});
            users.doc(doc.id).collection('friends').doc(user.uid).update({'isAccepted': true});
          }
        });
      });

    } catch (e) {
      print(e.toString());
    }
  }
}
