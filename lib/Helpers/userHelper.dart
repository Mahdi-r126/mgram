// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mgram/screens/chatScreen.dart';

import '../ProgressDialog.dart';

class UserHelper {
  static void showSnackbar(String title, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, fontFamily: "vazir", color: Colors.black87),
      ),
      backgroundColor: Colors.yellow[50],
      elevation: 20,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future RegisterUser(
      String email, String password, String name, BuildContext context) async {

        showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            const ProgressDialog(status: "please wait..."));

    await Firebase.initializeApp();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, ChatScreen.id);
      }
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }

  static Future LoginUser(
      String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            const ProgressDialog(status: "Logging in..."));

    await Firebase.initializeApp();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, ChatScreen.id);
      }
    } on Exception catch (e) {
      Navigator.pop(context);
      print('Exception details:\n $e');
      showSnackbar("Your Email or password is wrong", context);
    } catch (e) {
      Navigator.pop(context);
      print(e);
    }
  }
}
