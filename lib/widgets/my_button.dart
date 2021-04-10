import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.primary = Colors.white70,
    this.onPrimary = Colors.black,
    required this.press,
    this.text = "",
    required this.icon,
    required this.width,
    required this.height,
  }) : super(key: key);
  final Color primary;
  final Color onPrimary;
  final Function press;
  final String text;
  final Icon icon;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton.icon(
      icon: icon,
      style: ElevatedButton.styleFrom(
        primary: primary,
        onPrimary: onPrimary,
        minimumSize: Size(width, height),
        padding: EdgeInsets.symmetric(horizontal: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: press as void Function()?,
      label: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
