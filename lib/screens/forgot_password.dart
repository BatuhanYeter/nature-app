import 'package:flutter/material.dart';
import 'package:flutter_appp/constants.dart';
import 'package:flutter_appp/widgets/background.dart';
import 'package:flutter_appp/widgets/input_fields.dart';
import 'package:flutter_appp/widgets/my_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        BackgroundImage(image: 'assets/images/forgot_bg.jpeg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Text(
              "Forgot Password",
              style: bodyText,
            ),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Container(
                      width: size.width * 0.8,
                      child: Center(
                          child: Text(
                        "Please enter your email address and we will send a mail to change your password.",
                        style: bodyText,
                      )),
                    ),
                    SizedBox(height: 10),
                    TextInputField(
                      inputController: emailController,
                      icon: FontAwesomeIcons.envelope,
                      hintText: 'Email',
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyButton(
                      text: "Send",
                      onPrimary: Colors.black,
                      primary: Colors.white70,
                      press: () async {},
                      icon: Icon(FontAwesomeIcons.longArrowAltRight),
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
