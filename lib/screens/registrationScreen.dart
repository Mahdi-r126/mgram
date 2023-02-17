// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mgram/Helpers/userHelper.dart';
import 'package:mgram/constants.dart';
import 'package:mgram/widgets/brandButton.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
  late String name;

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
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        name = value;
                      },
                      style: const TextStyle(fontFamily: "bolt-regular"),
                      decoration: mTextFieldDecoration.copyWith(
                          hintText: "Enter your Name")),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      style: const TextStyle(fontFamily: "bolt-regular"),
                      decoration: mTextFieldDecoration.copyWith(
                          hintText: "Enter your Email")),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      style: const TextStyle(fontFamily: "bolt-regular"),
                      decoration: mTextFieldDecoration.copyWith(
                          hintText: "Enter your password")),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: BrandButton(
                        title: "Register",
                        color: Colors.blueAccent,
                        onPressed: () async {
                          var connectivityresult =
                              await Connectivity().checkConnectivity();
                          if (connectivityresult != ConnectivityResult.mobile &&
                              connectivityresult != ConnectivityResult.wifi) {
                            // ignore: use_build_context_synchronously
                            UserHelper.showSnackbar(
                                "Check your internet", context);
                            return;
                          }
                          if (!email.contains("@")) {
                            UserHelper.showSnackbar("Email is incorrect", context);
                            return;
                          }
                          if (password.length<7) {
                            UserHelper.showSnackbar("Password is too short", context);
                            return;
                          }
                          if (name.isEmpty) {
                            UserHelper.showSnackbar("Name required", context);
                            return;
                          }
                          UserHelper.RegisterUser(
                              email, password, name, context);
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
