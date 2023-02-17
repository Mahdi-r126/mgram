import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mgram/constants.dart';
import 'package:mgram/widgets/brandButton.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: "logo",
                    child: Container(
                      height: 250.0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    style: const TextStyle(fontFamily: "bolt-regular"),
                    decoration: mTextFieldDecoration.copyWith(hintText: "Enter your Name")
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    style: const TextStyle(fontFamily: "bolt-regular"),
                    decoration: mTextFieldDecoration.copyWith(hintText: "Enter your Email")
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    style: const TextStyle(fontFamily: "bolt-regular"),
                    decoration: mTextFieldDecoration.copyWith(hintText: "Enter your password")
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: BrandButton(title: "Register", color: Colors.blueAccent,onPressed: (){},)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
