import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sports extends StatefulWidget {
  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.4,
          width: size.width,
          padding: EdgeInsets.only(
              left: size.width * 0.06,
              right: size.width * 0.06,
              top: size.height * 0.03),
          child: ListView(
            children: [
              Text(
                "Sport Features",
                style: TextStyle(
                    fontSize: size.width * 0.055, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.05),
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pedometer",
                          style: TextStyle(fontSize: size.width * 0.05),
                        ),
                        Icon(
                          FontAwesomeIcons.angleRight,
                          size: size.width * 0.07,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/calculateDistance');
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Calculate the distance of my route",
                          style: TextStyle(fontSize: size.width * 0.05),
                        ),
                        Icon(
                          FontAwesomeIcons.angleRight,
                          size: size.width * 0.07,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "BMI Calculator",
                          style: TextStyle(fontSize: size.width * 0.05),
                        ),
                        Icon(
                          FontAwesomeIcons.angleRight,
                          size: size.width * 0.07,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Timer",
                          style: TextStyle(fontSize: size.width * 0.05),
                        ),
                        Icon(
                          FontAwesomeIcons.angleRight,
                          size: size.width * 0.07,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: size.height * 0.4,
          width: size.width,
          child: Column(
            children: [
              Row(
                children: [
                  Text("Today's step count: "),
                  Text("Your last BMI: ")
                ],
              ),
              Row(
                children: [
                  Text("Maybe Sth"),
                  Text("And...another thing?")
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
