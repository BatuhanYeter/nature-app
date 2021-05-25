import 'package:flutter/material.dart';
import 'package:flutter_appp/models/event.dart';
import 'package:flutter_appp/services/event_provider.dart';
import 'package:flutter_appp/services/events_service.dart';
import 'package:flutter_appp/utils.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  final Event? event;

  const EditEvent({Key? key, this.event}) : super(key: key);

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController(); // dispose it
  late DateTime fromDate;
  late DateTime toDate;
  final EventsService _eventsService = EventsService();

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    } else {
      final event = widget.event;

      titleController.text = event!.title;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Nature Calls"),
        leading: CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                SizedBox(
                  height: size.height * 0.05,
                ),
                buildDateTimePicker()
              ],
            ),
          )),
    );
  }

  Widget buildDateTimePicker() => Column(
        children: [buildFrom(), buildTo()],
      );

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          child
        ],
      );

  Widget buildFrom() => buildHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropDownField(
                    text: Utils.toDate(fromDate),
                    onClicked: () => pickFromDate(pickDate: true))),
            Expanded(
                child: buildDropDownField(
                    text: Utils.toTime(fromDate),
                    onClicked: () => pickFromDate(pickDate: false)))
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'TO',
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(toDate),
                  onClicked: () => pickToDate(pickDate: true),
                )),
            Expanded(
                child: buildDropDownField(
              text: Utils.toTime(toDate),
              onClicked: () => pickToDate(pickDate: false),
            ))
          ],
        ),
      );

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
          title: titleController.text,
          from: fromDate,
          to: toDate,
          description: 'Description',
          isAllDay: false);

      final isEditing = widget.event != null;

      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        // provider.editEvent(event, widget.event!);
        _eventsService.addEvent(event);
        // _eventsService.getCurrentEvents();
        Navigator.of(context).pop();
      } else {
        // provider.addEvent(event);
        _eventsService.addEvent(event);
        _formKey.currentState!.save();
        // _eventsService.getCurrentEvents();
      }

      Navigator.of(context).pop();
    }
  }

  Future pickFromDate({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return null;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() {
      fromDate = date;
    });
  }

  Future pickToDate({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);
    if (date == null) return null;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() {
      toDate = date;
    });
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);

      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Widget buildDropDownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildTitle() => TextFormField(
        style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.03),
        onFieldSubmitted: (_) => saveForm(),
        decoration: InputDecoration(
            border: UnderlineInputBorder(), hintText: 'Add Title'),
        controller: titleController,
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot be empty.' : null,
      );

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: saveForm,
            icon: Icon(Icons.done),
            label: Text('Save'))
      ];
}
