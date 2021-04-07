import 'package:flutter/material.dart';
import 'package:flutter_appp/constants.dart';
import 'package:flutter_appp/services/authentication_service.dart';
import 'package:flutter_appp/widgets/background.dart';
import 'package:flutter_appp/widgets/input_fields.dart';
import 'package:flutter_appp/widgets/my_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  final AuthenticationService auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        BackgroundImage(image: 'assets/images/bg.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextInputField(
                        inputController: emailController,
                        hintText: "Email",
                        icon: FontAwesomeIcons.envelope,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                      ),
                      PasswordInputField(
                        icon: FontAwesomeIcons.lock,
                        hintText: "Password",
                        passwordController: passwordController,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      PasswordInputField(
                        icon: FontAwesomeIcons.lock,
                        hintText: "Password again",
                        passwordController: passwordAgainController,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                width: size.width * 0.2,
                                height: size.height * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.bars,
                                  color: Colors.black,
                                )),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          MyButton(
                            press: () async {
                              if (_formKey.currentState!.validate() &&
                                  passwordController.text.trim() ==
                                      passwordAgainController.text.trim()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please wait')));
                                auth.signUp(context,
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                              } else if (passwordController.text.trim() !=
                                  passwordAgainController.text.trim()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Passwords do not match')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Something Went Wrong')));
                              }
                            },
                            text: "Sign Up",
                            icon: Icon(FontAwesomeIcons.arrowRight),
                            height: size.height * 0.08,
                            width: size.width * 0.6,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.white))),
                          child: Text(
                            "Already have an account?",
                            style: bodyText,
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, '/login'),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
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
                            onTap: () async {

                            },
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
                              if (_formKey.currentState!.validate() &&
                                  passwordController.text.trim() ==
                                      passwordAgainController.text.trim()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please wait')));
                                auth
                                    .signUp(context,
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                              } else if (passwordController.text.trim() !=
                                  passwordAgainController.text.trim()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Passwords do not match')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Something Went Wrong')));
                              }
                            },
                          ),
 */
/*
press: () async {
                            if (_formKey.currentState.validate() &&
                                passwordController.text.trim() ==
                                    passwordAgainController.text.trim()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please wait')));
                              auth
                                  .signUp(context,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim())
                                  .then((value) =>
                                      auth.emailVerification(context));
                            } else if (passwordController.text.trim() !=
                                passwordAgainController.text.trim()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Passwords do not match')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Something Went Wrong')));
                            }
                          }
 */
