import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/services/database.dart';
import 'package:flutter_appp/services/preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_string/random_string.dart';

class ChatRoom extends StatefulWidget {
  final String chatWithUserName, chatWithName;

  const ChatRoom(
      {Key? key, required this.chatWithUserName, required this.chatWithName})
      : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late String chatRoomId, messageId = "";
  late String myName, myProfilePic, myUserName, myEmail;
  TextEditingController messageController = TextEditingController();
  Stream<QuerySnapshot>? messageStream;

  getMyInfoFromSharedPreference() async {
    myName = await UserPreferences().getDisplayName();
    myProfilePic = await UserPreferences().getUserProfileUrl();
    myUserName = await UserPreferences().getUserName();
    myEmail = await UserPreferences().getUserEmail();

    chatRoomId = getChatRoomIdByUserName(widget.chatWithUserName, myUserName);
  }

  getChatRoomIdByUserName(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) {
    if (messageController.text.isNotEmpty) {
      String message = messageController.text;
      var lastMessageTimeStamp = DateTime.now();

      Map<String, dynamic> messageDataMap = {
        "message": message,
        "sentBy": myUserName,
        "timestamp": lastMessageTimeStamp,
      };
      // messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }
      DatabaseMethods()
          .addMessage(chatRoomId, messageId, messageDataMap)
          .then((value) {
        Map<String, dynamic> lastMessageDataMap = {
          "lastMessage": message,
          "lastMessageSentTimeStamp": lastMessageTimeStamp,
          "lastMessageSentBy": myUserName
        };
        DatabaseMethods().updateLastMessageSent(chatRoomId, lastMessageDataMap);

        if (sendClicked) {
          messageController.text = "";
          messageId = "";
        }
      });
    }
  }

  Widget chatMessageTile(String message, bool sentByMe) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:
          sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: size.width * 0.02, horizontal: size.width * 0.02),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width * 0.03),
              color: Theme.of(context).dialogBackgroundColor),
          padding: EdgeInsets.all(size.width * 0.02),
          child: Text(
            message,
            style: TextStyle(fontSize: size.width * 0.04),
          ),
        ),
      ],
    );
  }

  Widget chatMessages() {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: messageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(
                      bottom: size.height * 0.02, top: size.height * 0.02),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return chatMessageTile(ds.data()!["message"],
                        myUserName == ds.data()!["sentBy"]);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    // this will be await because gettings data from sharedpreferences takes time
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatWithName),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.8,
              child: chatMessages()),
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03, vertical: size.height * 0.015),
              child: Row(
                children: [
                  Expanded(
                    // whenever you use a textfield inside of a row, use it w/ expanded
                    child: TextField(
                      onChanged: addMessage(false),
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: "Send a message",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.028,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.send),
                      onPressed: () {
                        addMessage(true);
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
