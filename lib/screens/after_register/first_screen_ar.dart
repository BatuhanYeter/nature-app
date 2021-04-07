import 'package:flutter/material.dart';
import 'package:flutter_appp/widgets/my_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstScreenAR extends StatefulWidget {
  @override
  _FirstScreenARState createState() => _FirstScreenARState();
}

class _FirstScreenARState extends State<FirstScreenAR> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _giveVerse = false;
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
                Navigator.pushNamed(context, "/secondScreenAR");
              },
            ),
            SizedBox(height: size.height * 0.1,),
          ],
        ),
      ),
    );
  }
}
