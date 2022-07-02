// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterUser extends StatefulWidget {

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  String message = '';

  loggedIn() async {
    var uri = Uri.parse("http://localhost:8080/chats/users/loggedIn.php");
    var response = await http.post(uri, body: {
      "loggedIn": "true",
    });
  }

  loggedOut() async {
    var uri = Uri.parse("http://localhost:8080/chats/users/loggedIn.php");
    var response = await http.post(uri, body: {
      "loggedIn": "false",
    });
  }

  registerUser() async {
    if(phone.text != "" && name.text != ""){
      try{
        var uri = Uri.parse("http://192.168.0.121:8080/projects/Chats/users/register.php");
        var response = await http.post(uri, body: {
          "phone": phone.text,
          "name": name.text,
        });

        setState(() {
          message = jsonDecode(response.body);
        });

        print(message);
        if(message == "Register Success."){
          Navigator.pushReplacementNamed(context, '/friends');
          Fluttertoast.showToast(
            msg: message,
          );
          loggedIn();
        } else {
          Fluttertoast.showToast(
            msg: message,
          );
        }
      } catch(e) {
        print(e);
      }
    }
    else{
      Fluttertoast.showToast(
        msg: "The fields cannot be left blank.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/db.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.15),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                      hintText: 'Enter your name',
                      icon: Icon(Icons.person, size: 30, color: Colors.white70),
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                      hintText: 'Enter your phone number',
                      icon: Icon(Icons.phone, size: 30, color: Colors.white70),
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                GestureDetector(
                  onTap: (){
                    registerUser();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white70,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Center(
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Rancho',
                              letterSpacing: 1.5,
                              color: Colors.black,
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: TextStyle(
                        fontFamily: 'Rancho',
                        fontSize: 20,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'login',
                        style: TextStyle(
                          fontFamily: 'Rancho',
                          fontSize: 20,
                          color: Colors.red,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}