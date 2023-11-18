//
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Model/user.dart';
String VPNURL="http://localhost:8083/";
Future <dynamic> register (first_name,last_name,email,password) async{
String   url ="registration";
final response = await http.post(
  Uri.parse(VPNURL + 'user/register'),
  headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, dynamic>{
    'first_name': first_name,
    'last_name': last_name,
    'email': email,
    'password': password
  }),
);

if (response.statusCode == 201 || response.statusCode == 200) {
  // If the server did return a 201 CREATED response,
  // then parse the JSON.

  User u = User.fromJson(jsonDecode(response.body));
  print(jsonDecode(response.body));

  print(u);
  return u;
} else {
  var mess = jsonDecode(response.body)['message'];
  print(mess.runtimeType);
  // If the server did not return a 201 CREATED response,
  // then throw an exception.

  print("not logged");
  Fluttertoast.showToast(
      msg: mess,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  throw Exception('Failed to create account .');
}



}

