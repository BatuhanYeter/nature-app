import 'package:flutter/material.dart';
import 'package:flutter_appp/widgets/my_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecondScreenAR extends StatefulWidget {
  @override
  _SecondScreenARState createState() => _SecondScreenARState();
}

class _SecondScreenARState extends State<SecondScreenAR> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.teal[800],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyButton(
              width: size.width * 0.8,
              height: size.height * 0.08,
              icon: Icon(FontAwesomeIcons.arrowRight),
              primary: Colors.white,
              onPrimary: Colors.teal,
              text: "Next",
              press: () {
                Navigator.pushNamed(context, "/thirdScreenAR");
              },
            ),
            SizedBox(height: size.height * 0.1,),
          ],
        ),
      ),
    );
  }
}
