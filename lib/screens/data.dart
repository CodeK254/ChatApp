import 'package:http/http.dart' as http;
import 'dart:convert';

class Users{

  String name;
  String phone;
  String sent;

  Users({required this.name, required this.phone, required this.sent});

  Users.fromJSON(Map json):
    name = json["name"],
    phone = json["phone"],
    sent = json["sent"];

}