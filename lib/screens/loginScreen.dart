// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mgram/constants.dart';
import 'package:mgram/widgets/brandButton.dart';

import '../Helpers/userHelper.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

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
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      style: const TextStyle(fontFamily: "bolt-regular"),
                      decoration: mTextFieldDecoration.copyWith(
                          hintText: "Enter your email")),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
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
                        title: "Login",
                        color: Colors.lightBlueAccent,
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
                          if (password.length < 7) {
                            UserHelper.showSnackbar(
                                "Password is too short", context);
                            return;
                          }
                          UserHelper.LoginUser(email, password, context);
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
