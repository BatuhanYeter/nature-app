import 'package:flutter/material.dart';

showException(BuildContext context, {String message}){
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
              // TODO: Display the error type to the user. Done.
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Try Again'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}