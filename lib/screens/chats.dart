// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:chat_app/screens/friends.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {

  final Friends data;

  Chats({required this.data});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            fontFamily: 'MeriendaOne',
            fontSize: 23,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}