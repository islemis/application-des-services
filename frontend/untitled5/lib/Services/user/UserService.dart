
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Model/user.dart';
import '../env.dart';
import 'dart:io';


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
  final response = await http.get(Uri.parse("${VPNURL}MyUser/$userId"));
  print('Response Body: ${response.body}');
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
Future<void> updateUserProfile(
    int userId,
    Map<String, dynamic> userData,
    List<File> images,
    File profileImage,
    ) async {
  // Construct the request
  var request = http.MultipartRequest(
    'PUT',
    Uri.parse('$VPNURL/MyUser/$userId'),
  );

  // Add user data as fields
  request.fields['userJson'] = jsonEncode(userData);

  // Add images as files
  for (var i = 0; i < images.length; i++) {
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        images[i].path,
      ),
    );
  }

  // Add profile image as a file
  request.files.add(
    await http.MultipartFile.fromPath(
      'profil',
      profileImage.path,
    ),
  );

  try {
    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      print('Failed to update user. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
    // Handle errors, e.g., show a toast or navigate to an error page.
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



