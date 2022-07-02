// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:chat_app/screens/chats.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:chat_app/screens/data.dart';

class Friends extends StatefulWidget {

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  var users;

  _callNumber(String number) async {
    bool? called = await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future showFriends() async {
    // var uri = Uri.parse("https://karu-mart.000webhostapp.com/Chats/users.php");
    var uri = Uri.parse("http://192.168.0.121:8080/projects/Chats/users/users.php");
    var response = await http.get(uri);

    setState(() {
      users = jsonDecode(response.body);
    });

    return users;
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: MediaQuery.of(context).size.height * 0.09,
            // centerTitle: true,
            elevation: 0.0,
            shadowColor: Colors.white,
            leading: GestureDetector(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 25,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "All Users",
                style: TextStyle(
                  fontFamily: 'MeriendaOne',
                  fontSize: 23,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.purple,
                  ),
                ),
              )
            ],
          ),
          body: FutureBuilder(
            future: showFriends(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                Fluttertoast.showToast(
                  msg: "Snapshot Error!!!",
                );
              }
              return 
               snapshot.hasData ?
                    ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            ListTile(
                              onTap: (){
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context)=> Chats(data: users[index]))
                                );
                              },
                              selectedTileColor: Colors.white70,
                              tileColor: Colors.transparent,
                              title: Text(
                                users[index]['name'],
                                style: TextStyle(
                                  fontFamily: 'Rancho',
                                  fontSize: 18,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: ()=> _callNumber("${users[index]['phone']}"),
                                child: Text(
                                  users[index]['phone'],
                                  style: TextStyle(
                                    fontFamily: 'Rancho',
                                    fontSize: 12,
                                    letterSpacing: 1.5,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              height: 1,
                            ),
                          ],
                        );
                      }
                    )
          //       ListView(
          //         children: data.map((user) => Column(
          //           children: [
          //             ListTile(
          //               onTap: (){

          //               },
          //               selectedTileColor: Colors.white70,
          //               tileColor: Colors.transparent,
          //               title: Text(
          //                 user.name.toString(),
          //                 style: TextStyle(
          //                   fontFamily: 'Rancho',
          //                   fontSize: 18,
          //                   letterSpacing: 1.5,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //               trailing: GestureDetector(
          //                 onTap: ()=> _callNumber("${user.phone}"),
          //                 child: Text(
          //                   user.phone.toString(),
          //                   style: TextStyle(
          //                     fontFamily: 'Rancho',
          //                     fontSize: 12,
          //                     letterSpacing: 1.5,
          //                     color: Colors.blue,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Divider(
          //               color: Colors.white,
          //               height: 1,
          //             ),
          //           ],
          //         ), 
          //         ).toList())
                :
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
                );
            },
          ),
        ),
      ]
    );
  }
}

                // ListView.builder(
                //   itemCount: users.length,
                //   itemBuilder: (context, index){
                //     return Column(
                //       children: [
                //         ListTile(
                //           onTap: (){

                //           },
                //           selectedTileColor: Colors.white70,
                //           tileColor: Colors.transparent,
                //           title: Text(
                //             users[index]['name'],
                //             style: TextStyle(
                //               fontFamily: 'Rancho',
                //               fontSize: 18,
                //               letterSpacing: 1.5,
                //               color: Colors.white,
                //             ),
                //           ),
                //           trailing: GestureDetector(
                //             onTap: ()=> _callNumber("${users[index]['phone']}"),
                //             child: Text(
                //               users[index]['phone'],
                //               style: TextStyle(
                //                 fontFamily: 'Rancho',
                //                 fontSize: 12,
                //                 letterSpacing: 1.5,
                //                 color: Colors.blue,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Divider(
                //           color: Colors.white,
                //           height: 1,
                //         ),
                //       ],
                //     );
                //   }
                // )