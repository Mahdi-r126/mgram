import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mgram/Helpers/chatHelper.dart';
import 'package:mgram/screens/loginScreen.dart';

import '../constants.dart';

late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late String messageText;
  late String userName;
  TextEditingController messageConroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/background1.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            leading: null,
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.popAndPushNamed(context, LoginScreen.id);
                  }),
            ],
            title: const Text('⚡️Chat',
                style: TextStyle(fontFamily: "bolt-regular", color: Colors.white)),
            backgroundColor: Colors.black38,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MessagesStream(),
                Container(
                  decoration: mMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                              color: Colors.white, fontFamily: "vazir"),
                          controller: messageConroller,
                          onChanged: (value) {
                            messageText = value;
                          },
                          decoration: mMessageTextFieldDecoration,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          messageConroller.clear();
                          userName =
                              await ChatHelper.getUserName(loggedInUser.uid);
                          ChatHelper.sendMessage(
                              messageText, loggedInUser, userName);
                        },
                        child: const Text(
                          'Send',
                          style: mSendButtonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class MessagesStream extends StatelessWidget {
  MessagesStream({super.key});
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            _fireStore.collection('messages').orderBy("create at").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data?.docs.reversed;
            List<MessageTile> messageWidgets = [];
            for (var message in messages!) {
              final messageText = message.data()['text'];
              final messageSender = message.data()['userName'];
              final senderEmail = message.data()['sender'];

              bool isMe;
              final currentUser = loggedInUser.email;
              if (currentUser == senderEmail)
                isMe = true;
              else
                isMe = false;

              final messageWidget = MessageTile(
                text: messageText,
                senderName: messageSender,
                isMe: isMe,
              );
              messageWidgets.add(messageWidget);
            }
            return Expanded(
              child: ListView(
                reverse: true,
                padding: const EdgeInsets.all(15),
                children: messageWidgets,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class MessageTile extends StatelessWidget {
  final String text;
  final String senderName;
  final bool isMe;
  MessageTile(
      {required this.text, required this.senderName, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            (isMe == true) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            senderName,
            style: const TextStyle(
                color: Colors.white70,
                fontFamily: "bolt-semibold",
                fontSize: 12),
          ),
          const SizedBox(
            height: 3,
          ),
          Material(
              borderRadius: (isMe == true)
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
              elevation: 5,
              color: (isMe) ? Colors.blue[900] : Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: (isMe) ? Colors.white : Colors.black87,
                        fontFamily: "vazir",
                        fontSize: 15),
                  ))),
        ],
      ),
    );
  }
}
