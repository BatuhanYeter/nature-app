import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:flutter_appp/models/event_data_source.dart';
import 'package:flutter_appp/screens/event_viewing_page.dart';
import 'package:flutter_appp/services/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    final selectedEvents = applicationBloc.allEvents;

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text('No events found!', style: TextStyle(fontSize: MediaQuery
            .of(context)
            .size
            .height * 0.02),),
      );
    }

    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(applicationBloc.allEvents),
      initialDisplayDate: DateTime.now(),
      appointmentBuilder: appointmentBuilder,
      onTap: (details) {
        if(details.appointments == null) return;

        final event = details.appointments!.first;

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventViewingPage(event: event)));
      },
    );
  }

  Widget appointmentBuilder(
      BuildContext context,
      CalendarAppointmentDetails details
      ) {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: MediaQuery
              .of(context)
              .size
              .height * 0.02,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
