import 'package:flutter_appp/models/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<dynamic> source) {
    appointments = source;
  }

  // Event getEvent(int index) => appointments![index];

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;

  @override
  String getSubject(int index) => appointments![index].title;

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;
}