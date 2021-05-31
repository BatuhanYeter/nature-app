import 'package:flutter/material.dart';
import 'package:flutter_appp/constants.dart';
import 'package:flutter_appp/services/social_service.dart';
import 'package:flutter_appp/widgets/background.dart';
import 'package:flutter_appp/widgets/input_fields.dart';
import 'package:flutter_appp/widgets/my_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddFriend extends StatelessWidget {
  AddFriend({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SocialService socialService = SocialService();
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
              "Add a Friend",
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
                            "Please enter the email address of your friend",
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
                      press: () async {
                        socialService.friendRequest(context, email: emailController.text.trim());
                      },
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
