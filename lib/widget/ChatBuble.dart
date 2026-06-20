import 'package:chat_app/constans.dart';
import 'package:chat_app/models/massage.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({required this.massageBuble});

  final Massage massageBuble;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          top: 32,
          bottom: 32,
          right: 16,
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        constraints: BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          massageBuble.massages,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  ChatBubleForFriend({required this.massageBuble});

  final Massage massageBuble;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          top: 32,
          bottom: 32,
          right: 16,
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        constraints: BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          massageBuble.massages,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
