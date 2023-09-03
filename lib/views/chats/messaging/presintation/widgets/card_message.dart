
import 'package:flutter/material.dart';

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
          const Text('hello'),
          Material(
              borderRadius: isMe
                  ? const BorderRadius.only(bottomRight: Radius.circular(20))
                  : const BorderRadius.only(bottomLeft: Radius.circular(20)),
              color: isMe ? Colors.blue : Colors.blueGrey,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "welcom",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
