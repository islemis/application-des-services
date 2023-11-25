//
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Model/user.dart';

String VPNURL="http://192.168.1.15:8083/";
//user registre
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
      msg: "Probléme de registre ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  throw Exception('Failed to create account .');
}

}
//login
Future<User> authenticateUser(String email, String password) async {

  final response = await http.post(
    Uri.parse(VPNURL + 'api/auth'), // Remplacez par l'URL réelle de votre API
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
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
        msg: "email ou mot de passe incorrecte  ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

    throw Exception('Failed to create account .');
  }

}

void logout() {
  // 1. Clear the stored token
  clearAuthToken();

}

void clearAuthToken() {
  // Clear the authentication token from local storage or cookies
  // For example, in Flutter/Dart using shared_preferences package:
  SharedPreferences.getInstance().then((prefs) {
    prefs.remove('accesToken');
  });
}



