import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/services/social_service.dart';
import 'package:flutter_appp/widgets/background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({Key? key}) : super(key: key);

  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('friends')
      .snapshots();
  final SocialService socialService = SocialService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return Stack(children: <Widget>[
          Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.userPlus),
                  onPressed: () => Navigator.pushNamed(context, '/addFriend'),
                )
              ],
            ),
            body: Column(
              children: [
                Text("Pending Requests"),
                Container(
                    width: size.width,
                    height: size.height * 0.4,
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Row(
                            children: [
                              if(document.data()!['isAccepted'] == false)
                              Text(document.data()!['name'].toString()),
                              if(document.data()!['isAccepted'] == false)
                              IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () async {
                                    socialService.acceptRequest(
                                        document.data()!['email']);
                                  }),
                              if(document.data()!['isAccepted'] == false)
                              IconButton(
                                  icon: Icon(Icons.close), onPressed: () {}),
                            ],
                          ),
                        );
                      }).toList(),
                    )),
                Text("Friends"),
                Container(
                    width: size.width,
                    height: size.height * 0.4,
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Row(
                            children: [
                              if(document.data()!['isAccepted'] == true)
                              Text(document.data()!['name'].toString()),
                            ],
                          ),
                        );
                      }).toList(),
                    )),
              ],
            ),
          ),
        ]);
      },
    );
  }
}
