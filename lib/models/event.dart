import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;

  Event(
      {required this.title,
      required this.description,
      required this.from,
      required this.to,
      this.isAllDay = false});


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'from': from,
      'to': to,
      'isAllDay': isAllDay
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      description: map['description'],
      from: DateTime.fromMillisecondsSinceEpoch(map['from']),
      to: DateTime.fromMillisecondsSinceEpoch(map['to']),
      isAllDay: map['isAllDay'],
    );
  }
  factory Event.fromDS(String id, Map<String, dynamic> data) {
    return Event(
      title: data['title'],
      description: data['description'],
      from: DateTime.fromMillisecondsSinceEpoch(data['from']),
      to: DateTime.fromMillisecondsSinceEpoch(data['to']),
      isAllDay: data['isAllDay'],
    );
  }
}
