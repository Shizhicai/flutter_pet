import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet/res/colours.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Chat页面',
        style: TextStyle(
            color: Colours.color_222,
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
