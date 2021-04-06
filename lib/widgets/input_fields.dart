import 'package:flutter/material.dart';
import 'package:flutter_appp/constants.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    this.textInputType,
    this.textInputAction,
    required this.passwordController,
  }) : super(key: key);

  final IconData icon;
  final String hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.black12.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    icon,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: bodyText),
            obscureText: true,
            style: bodyText,
            keyboardType: textInputType,
            textInputAction: textInputAction,
          ),
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    this.textInputType,
    this.textInputAction,
    required this.inputController,
  }) : super(key: key);

  final IconData icon;
  final String hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.black12.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
            controller: inputController,
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    icon,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                hintText: hintText,
                hintStyle: bodyText),
            style: bodyText,
            keyboardType: textInputType,
            textInputAction: textInputAction,
          ),
        ),
      ),
    );
  }
}
