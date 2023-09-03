import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/constant.dart';


class ChatScreen extends StatefulWidget {
  static const id = "/chat";

  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User user;
  dynamic messages;

  TextEditingController controller = TextEditingController();

  void getCurrentUser() {
    user = _auth.currentUser!;
    print(user.email);
  }

 
  @override
  void initState() {
    getCurrentUser();
    
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
                  Navigator.pushNamed(context, "/chats");
                //Implement logout functionality
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
                stream: _firestore
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> messages = snapshot.data!.docs;
                    return Expanded(
                        child: ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return MessageBuble(
                                messages: messages,
                                sender: user.email!,
                                index: index,
                                isMe: messages[index]['sender'] == user.email,
                              );
                            }));
                  }
                  return const Text('loading ...');
                  // return  Expanded(
                  //   child: ListView(
                  //     padding: EdgeInsets.symmetric(horizontal: 16),
                  //     children: [
                  //       for (var item in messages.docs) ...{
                  //         Text('${item['text']}',style:
                  //         TextStyle(fontSize: 20),)}
                  //     ],
                  //   ),
                  // );
                }),
            Container(
              decoration: ConstantStayles.kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: ConstantStayles.kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print(controller.text);
                      _firestore.collection('messages').add({
                        'text': controller.text,
                        'sender': user.email,
                        'time': DateTime.now()
                      });
                      controller.clear();
                    },
                    child: const Text(
                      'Send',
                      style:ConstantStayles.kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBuble extends StatelessWidget {
  const MessageBuble({
    Key? key,
    required this.messages,
    required this.sender,
    required this.index,
    required this.isMe,
  }) : super(key: key);

  final List messages;
  final String sender;
  final int index;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text('${messages[index]['sender']}'),
          Material(
              borderRadius: isMe
                  ? const BorderRadius.only(bottomRight: Radius.circular(20))
                  : const BorderRadius.only(bottomLeft: Radius.circular(20)),
              color: isMe ? Colors.blue : Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${messages[index]['text']}",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
