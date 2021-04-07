import 'package:flutter/material.dart';
import 'package:flutter_appp/widgets/my_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThirdScreenAR extends StatefulWidget {
  @override
  _ThirdScreenARState createState() => _ThirdScreenARState();
}

class _ThirdScreenARState extends State<ThirdScreenAR> {
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
                // TODO: SplashScreen/LoadingScreen
                Navigator.pushNamed(context, "/home");
              },
            ),
            SizedBox(height: size.height * 0.1,),
          ],
        ),
      ),
    );
  }
}
