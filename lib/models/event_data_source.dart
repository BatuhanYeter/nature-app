import 'package:flutter_appp/models/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(source) {
    appointments = source;
  }

  Event getEvent(int index) => appointments![index];

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}