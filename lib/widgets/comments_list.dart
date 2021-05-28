import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:flutter_appp/models/comment.dart';
import 'package:flutter_appp/services/places_service.dart';
import 'package:provider/provider.dart';

class CommentsList extends StatefulWidget {
  const CommentsList({Key? key, required this.placeId}) : super(key: key);

  final String placeId;

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final applicationBloc = Provider.of<ApplicationBloc>(context);
    // final comments = applicationBloc.comments;
    // final int len = comments.where((element) => element.placeId == widget.placeId).length;
    final Stream<QuerySnapshot> _commentsStream = FirebaseFirestore.instance
        .collection('comments')
        .where('placeId', isEqualTo: widget.placeId)
        .snapshots();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return StreamBuilder(
        stream: _commentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return Padding(
            padding: EdgeInsets.all(size.width * 0.01),
            child: ExpansionTile(
              leading: Icon(Icons.comment),
              title: Text("Comments"),
              trailing: Text(snapshot.data!.docs.length.toString()),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: FutureBuilder(
                        future: users.doc(document.data()!['by'].isEmpty == true ? 'znRmYbNYg5sZxBfjQsgl' : document.data()!['by']).get(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Text("Document does not exist");
                          }
                          if (snapshot.connectionState == ConnectionState.done) {

                            return Text(snapshot.data!.data()!['name'] == null ? 'Anonymous' : snapshot.data!.data()!['name'].toString());
                          }
                          return CircularProgressIndicator();
                        }
                      ),
                      subtitle: Text(document.data()!['comment'], textAlign: TextAlign.left,),
                    ),
                    Divider(),
                  ],
                );
              }).toList(),
            ),
          );
        });
  }
}

class _SingleComment extends StatelessWidget {
  final int index;

  const _SingleComment({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    final comments = applicationBloc.comments;
    final Comment commentData = comments[index];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(commentData.by),
          Text(
            commentData.comment,
            textAlign: TextAlign.left,
          ),
          Divider(),
        ],
      ),
    );
  }
}
