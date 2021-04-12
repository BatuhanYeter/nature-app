import 'package:flutter/material.dart';

class NotificationRow extends StatelessWidget {
  const NotificationRow({
    Key? key, required this.text, required this.isActive,
  }) : super(key: key);

  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(fontSize: 16),),
            Switch(value: isActive, onChanged: (bool val) {})
          ],
        )
      ],
    );
  }
}
