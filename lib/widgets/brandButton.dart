import 'package:flutter/material.dart';

import '../screens/loginScreen.dart';

class BrandButton extends StatelessWidget {
  String title;
  Color color;
  void Function()? onPressed;
  BrandButton({super.key, required this.title, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: color,
      height: 50,
      child: const Text("Login",
          style: TextStyle(fontFamily: "bolt-semibold", color: Colors.white)),
      onPressed: () {
        onPressed;
      },
    );
  }
}
