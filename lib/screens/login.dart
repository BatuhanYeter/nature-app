import 'package:flutter/material.dart';
import 'package:flutter_appp/constants.dart';
import 'package:flutter_appp/services/authentication_service.dart';
import 'package:flutter_appp/services/updated_auth.dart';
import 'package:flutter_appp/widgets/background.dart';
import 'package:flutter_appp/widgets/input_fields.dart';
import 'package:flutter_appp/widgets/my_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthenticationService auth = AuthenticationService();
    final AuthMethods auth_2 = AuthMethods();
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        BackgroundImage(
          image: 'assets/images/bg.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextInputField(
                              inputController: emailController,
                              icon: FontAwesomeIcons.envelope,
                              hintText: "Email",
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.emailAddress,
                            ),
                            PasswordInputField(
                                passwordController: passwordController,
                                icon: FontAwesomeIcons.lock,
                                hintText: "Password",
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.name),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, '/forgotPassword'),
                              child: Text(
                                'Forgot Password?',
                                style: bodyText,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                auth_2.signInWithGoogle(context);
                              },
                              child: Container(
                                width: size.width * 0.2,
                                height: size.height * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/icons/google.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            MyButton(
                              press: () async {
                                auth.signIn(context,
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                              },
                              text: "Login",
                              icon: Icon(FontAwesomeIcons.arrowRight),
                              height: size.height * 0.08,
                              width: size.width * 0.6,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, "/signUp")},
                  child: Container(
                    child: Text(
                      'Create an account',
                      style: bodyText,
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.white))),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                )
              ]),
        )
      ],
    );
  }
}

/*
Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/icons/google.png'))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/icons/facebook.png'))),
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Icon(
                                  FontAwesomeIcons.bars,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {},
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            auth.signIn(context,
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                          },
                        ),
 */
