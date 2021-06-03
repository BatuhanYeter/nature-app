import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:flutter_appp/models/event.dart';
import 'package:flutter_appp/services/event_provider.dart';
import 'package:flutter_appp/utils.dart';
import 'package:provider/provider.dart';

class CurrentUserEvents extends StatelessWidget {

  const CurrentUserEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    final events = applicationBloc.events;
    print("-----------" + events.length.toString());
    print("-----------" + events[0].from.toString());
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(size.height * 0.02),
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("From", style: TextStyle(fontSize: 20))),
                      Expanded(child: Text(Utils.toDateTimeString(events[index].from))),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("To", style: TextStyle(fontSize: 20))),
                      Expanded(child: Text(Utils.toDateTimeString(events[index].to))),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    events[index].title,
                    style: TextStyle(fontSize: size.height * 0.03),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Text(
                    events[index].description,
                    style: TextStyle(fontSize: size.height * 0.025),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
