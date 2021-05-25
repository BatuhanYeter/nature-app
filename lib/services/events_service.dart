import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_appp/models/event.dart';

class EventsService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addEvent(Event event) async {
    try {
      User user = auth.currentUser!;
      CollectionReference events = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('events');
      var eventData = {
        'title': event.title,
        'from': event.from,
        'to': event.to,
        'description':
            event.description.isEmpty ? "default desc" : event.description,
        'isAllDay': event.isAllDay
      };

      events.add(eventData);
    } catch (e) {
      print(e.toString());
    }
  }

/*
  Future getCurrentEvents() async {
    try {
      User user = auth.currentUser!;
      var events = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('events')
          .get();

      return events as List<Event>;
    } catch (e) {
      print(e.toString());
    }
  } */

  Future getEvents() async {
    try {
      User user = auth.currentUser!;
      var events = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('events')
          .get();

      return events.docs.map((doc) => Event(
          title: doc['title'],
          description: doc['description'],
          from: doc['from'].toDate(),
          to: doc['to'].toDate())).toList();
    } catch (e) {
      print(e.toString());
    }
  }
}
