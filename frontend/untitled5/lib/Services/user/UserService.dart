//
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled5/Services/env.dart';
import '../../Model/user.dart';


//user registre
Future <User> register (firstName,lastName,email,password) async{
final response = await http.post(
  Uri.parse(VPNURL + "MyUser/addUser"),
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
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

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
    //secureStorage stocké l'email et password
    await secureStorage.write(key: 'email', value: email);
    await secureStorage.write(key: 'password', value: password);
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
//getUserFromToken
/*Future<User> getUserFromToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('accessToken') ?? '';
  return decodeToken(token);
}*/


//getUserByEmail
Future<User> getUserByEmail() async {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage(); // Initialize the instance

  String? email = await secureStorage.read(key: 'email');
  print('Fetching user data for email: $email');

  final response = await http.get(Uri.parse("${VPNURL}MyUser/email/$email"));
  print('API URL: ${VPNURL}email/$email');
  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

//getUserById
Future<User> getUserById(int userId) async {
  final response = await http.get(Uri.parse('$VPNURL/$userId'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

//getAllUsers
Future<List<User>> getUsers() async {
  final response = await http.get(Uri.parse('$VPNURL/getUsers'));

  if (response.statusCode == 200) {
    Iterable users = jsonDecode(response.body);
    return List<User>.from(users.map((user) => User.fromJson(user)));
  } else {
    throw Exception('Failed to load users');
  }
}
//UpdateUser
Future<void> updateUser(int userId, String userJson, List files) async {
  final response = await http.put(
    Uri.parse('$VPNURL/$userId'),
    body: {
      'user': userJson,
      // Add other parameters for file uploads if needed
    },
  );

  if (response.statusCode == 200) {
    print('User updated successfully');
  } else {
    throw Exception('Failed to update user');
  }
}





























//logout
void logout() {
  // 1. Clear the stored token
  clearAuthToken();

}
void clearAuthToken() {
  // Clear the authentication token from local storage or cookies
  // For example, in Flutter/Dart using shared_preferences package:
  SharedPreferences.getInstance().then((prefs) {
    prefs.remove('accessToken');
  });
}



