//
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Model/user.dart';
String VPNURL="http://192.168.1.13:8083/";
Future <User> register (firstName,lastName,email,password) async{
String   url ="registration";
final response = await http.post(
  Uri.parse(VPNURL + 'registration'),
  headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, dynamic>{
    'firstName': firstName,
    'lastName': lastName,
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
 // var mess = jsonDecode(response.body)['message'];
 // print(mess.runtimeType);
  // If the server did not return a 201 CREATED response,
  // then throw an exception.

  print("not logged");
  Fluttertoast.showToast(
      msg: "Problem de register ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  throw Exception('Failed to create account .');
}



}

