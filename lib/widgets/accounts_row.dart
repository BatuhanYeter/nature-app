import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountRow extends StatelessWidget {
  const AccountRow({
    Key? key, required this.text, required this.press,
  }) : super(key: key);

  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press as void Function()?,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text, style: TextStyle(fontSize: 16),),
              Icon(FontAwesomeIcons.angleRight, size: size.width * 0.07,),
            ],
          )
        ],
      ),
    );
  }
}
