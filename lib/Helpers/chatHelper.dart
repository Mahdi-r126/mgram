import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatHelper {
  static Future sendMessage(String message, User loggedInUser) async {
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

    _fireStore
        .collection("messages")
        .add({'text': message, 'sender': loggedInUser.email});
  }
}
