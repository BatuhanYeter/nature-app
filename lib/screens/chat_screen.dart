import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/screens/chat_room.dart';
import 'package:flutter_appp/services/database.dart';
import 'package:flutter_appp/services/preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController searchController = TextEditingController();
  late String myName, myProfilePic, myUserName, myEmail;
  Stream<QuerySnapshot>? usersStream;
  Stream<QuerySnapshot>? chatRoomStream;
  bool isSearching = false;

  getMyInfoFromSharedPreference() async {
    myName = await UserPreferences().getDisplayName();
    myProfilePic = await UserPreferences().getUserProfileUrl();
    myUserName = await UserPreferences().getUserName();
    myEmail = await UserPreferences().getUserEmail();
  }

  getChatRoomIdByUserName(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchButtonClick() async {
    isSearching = true;
    setState(() {});
    usersStream =
        await DatabaseMethods().getUserByUserName(searchController.text);
    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
        stream: chatRoomStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return ChatRoomListTile(
                      chatRoomId: ds.id,
                      myUserName: myUserName,
                      lastMessage: ds.data()!['lastMessage'],
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget searchUsersList() {
    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return searchListUserTile(
                        photoUrl: ds.data()!["photoUrl"],
                        name: ds.data()!['name'],
                        username: ds.data()!['username'],
                        email: ds.data()!['email']);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget searchListUserTile({required String photoUrl, name, username, email}) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUserName(myUserName, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username]
        };

        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatRoom(
                      chatWithName: name,
                      chatWithUserName: username,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: Row(
          children: [
            ClipRRect(
              child: Image.network(
                photoUrl,
                width: size.width * 0.15,
                height: size.height * 0.1,
              ),
              borderRadius: BorderRadius.circular(size.width * 0.1),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(name), Text(email)],
            )
          ],
        ),
      ),
    );
  }

  getChatRooms() async {
    chatRoomStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
    setState(() {});
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all((MediaQuery.of(context).size.height * 0.02)),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(hintText: "Search a friend"),
                    )),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (searchController.text != "") {
                          onSearchButtonClick();
                        }
                      },
                    )
                  ],
                ),
              ),
              isSearching ? searchUsersList() : chatRoomsList()
            ],
          ),
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUserName;

  ChatRoomListTile(
      {Key? key,
      required this.chatRoomId,
      required this.lastMessage,
      required this.myUserName})
      : super(key: key);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String photoUrl = "";
  late String username, name;

  getThisUsersInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUserName, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);

    name = querySnapshot.docs[0].data()['name'];
    photoUrl = querySnapshot.docs[0].data()['photoUrl'];

    setState(() {});
  }

  doThisBeforeLaunch() async {
    await getThisUsersInfo();
  }

  @override
  void initState() {
    doThisBeforeLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return photoUrl != ""
        ? GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatRoom(
                  chatWithName: name,
                  chatWithUserName: username,
                )));
      },
          child: Row(
              children: [
                ClipRRect(
                  child: Image.network(
                    photoUrl,
                    width: size.width * 0.125,
                    height: size.height * 0.1,
                  ),
                  borderRadius: BorderRadius.circular(size.width * 0.1),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: size.height * 0.02),
                    ),
                    SizedBox(height: size.height * 0.002,),
                    Text(widget.lastMessage)
                  ],
                )
              ],
            ),
        )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
