import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

class ChatHelper {
  static Future sendMessage(
      String message, User loggedInUser, String name) async {
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

    _fireStore
        .collection("messages")
        .add({'text': message, 'sender': loggedInUser.email, 'userName': name,'create at':DateTime.now().toString()});
  }

  static Future<String> getUserName(String id) async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    if (documentSnapshot.exists) {
      print(documentSnapshot["name"]);
      String name = documentSnapshot["name"];
      return name;
    } else {
      print("name is not found.");
      return ""; // None "X" image
    }
  }
  
}
