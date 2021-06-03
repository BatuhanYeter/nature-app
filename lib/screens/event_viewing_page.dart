import 'package:flutter/material.dart';
import 'package:flutter_appp/models/event.dart';
import 'package:flutter_appp/screens/edit_event.dart';
import 'package:flutter_appp/services/event_provider.dart';
import 'package:flutter_appp/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<EventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.edit),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditEvent(event: event,))),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.trash),
            onPressed: () {
              provider.deleteEvent(event);
              Navigator.of(context).pop();
            },
          ),

        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(size.height * 0.04),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(flex: 2, child: Text("From", style: TextStyle(fontSize: 20))),
                  Expanded(child: Text(Utils.toDateTimeString(event.from))),
                ],
              ),
              SizedBox(height: size.height * 0.02,),
              Row(
                children: [
                  Expanded(flex: 2, child: Text("To", style: TextStyle(fontSize: 20))),
                  Expanded(child: Text(Utils.toDateTimeString(event.to))),
                ],
              ),
              SizedBox(height: size.height * 0.02,),
              Text(event.title, style: TextStyle(fontSize: size.height * 0.03),),
              SizedBox(height: size.height * 0.015,),
              Text(event.description, style: TextStyle(fontSize: size.height * 0.025),),

            ],
          ),
        ],
      ),
    );
  }
}
