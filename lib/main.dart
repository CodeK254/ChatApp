// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:chat_app/intro/splashScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/screens/friends.dart';
import 'package:chat_app/users/login.dart';
import 'package:chat_app/users/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=> SplashScreen(),
        '/loader':(context) => Loader(),
        '/register': (context)=> RegisterUser(),
        '/login': (context)=> UserLogin(),
        '/friends': (context)=> Friends(),
      },
    ),
  );
}

class Loader extends StatefulWidget {

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {

  var answer = [];

  loggedIn() async {
    var uri = Uri.parse("http://192.168.0.121:8080/chats/users/logged.php");
    var response = await http.get(uri);

    setState(() {
      answer = jsonDecode(response.body);
    });

    // print(answer);

    return answer;
  }

  @override

  initState() {
    super.initState();

    loggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loggedIn(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          Fluttertoast.showToast(msg: "Snapshot threw an error!!!");
        }
        if(snapshot.hasData){
          return Friends();
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      }
    );
      // answer.first['loggedIn'] == 'true' ?
      //   Friends()
      // :
      //   RegisterUser()
      // ;
  }
}