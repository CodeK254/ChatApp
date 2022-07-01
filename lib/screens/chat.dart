// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPageScreen extends StatefulWidget {

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  
  TextEditingController txt = TextEditingController();
  bool sentByMe = true;

  sendMessage() async {
    var url = Uri.parse('https://karu-mart.000webhostapp.com/Chats/type.php');

    var response = await http.post(url, body: {
      "message" : txt.text,
      "sentByMe": "true",
    });

    print("Sent");

    print(jsonDecode(response.body));
  } 

  var chats;

  Future loadMessages() async {
    var url = Uri.parse('https://karu-mart.000webhostapp.com/Chats/chats.php');

    var response = await http.get(url);

    setState(() {
      chats = json.decode(response.body);      
    });

    return chats;
  }
  
  _messageInput() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height * 0.15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: EdgeInsets.only(left: 7),
              child: Icon(
                Icons.attach_file,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              controller: txt,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Enter your message...',
                fillColor: Colors.white70,
                filled: true,
                border: UnderlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          SizedBox(width: 3),
          GestureDetector(
            onTap: () async {
              print(txt.text);
              print("Loaded");
              await sendMessage();
            },
            child: Padding(
              padding: EdgeInsets.all(2),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadMessages(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasError)
        {
          Fluttertoast.showToast(
            msg: 'Snapshot has Error!!!',
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_LONG,
            fontSize: 15,
            backgroundColor: Colors.teal,
          );
        }
        return snapshot.hasData ? Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index){
                  if (chats[index]['id'] == '1') {
                    return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.95,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      chats[index]['message'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Rancho',
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      chats[index]['sent'],
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Rancho',
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );                  
                  } else if(chats[index]['sentByMe'] == "true"){
                    return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.85,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.teal[300],
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      chats[index]['message'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Rancho',
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      chats[index]['sent'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Rancho',
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                  } else {
                    return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.85,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      chats[index]['message'],
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Rancho',
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      chats[index]['sent'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Rancho',
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                  }
                },
              ),
            ),
            _messageInput(),
          ],
        )
        :
        Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: Colors.black,
          ),
        );
      },
    );
  }
}