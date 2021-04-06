import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function press;
  final Color color;
  final Icon icon;

  const RoundedButton(
      {Key? key,
      required this.press,
      this.color = Colors.white,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.2,
      height: size.height * 0.08,
      color: Colors.white,
      child: IconButton(
        icon: icon,
        color: color,
        onPressed: press as void Function()?,
      ),
    );
  }
}
