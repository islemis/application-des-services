import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled5/Services/env.dart';

import '../../Model/offer/offer.dart';

Future<void> addOffre( titre, categoriename, details, address, List images, prix, description,idcategorie) async {
 // Replace with your VPN URL

  var request = http.MultipartRequest('POST', Uri.parse('$VPNURL/services/addService'));
  request.fields.addAll({
    'service': jsonEncode({
      "titre": titre,
      "price": prix,
      "description": description,
      "details": details, // You may want to replace this with actual details

      "adresse": address, // You may want to replace this with the actual address
      "categories": [
        {
          "id": idcategorie,
          "name":categoriename,
        }
      ]
    }),
  });

  for (var i = 0; i < images.length; i++) {
    request.files.add(await http.MultipartFile.fromPath(
      'images',
      File(images[i].path).path,
    ));
  }

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server returns a 201 CREATED or 200 OK response, you can handle the success here.
      // You might want to parse the response if the server sends any meaningful data.
      Fluttertoast.showToast(
        msg: "Secc",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      // If the server did not return a 201 CREATED or 200 OK response,
      // throw an exception and handle the failure.
      print("not logged");
      Fluttertoast.showToast(
        msg: "Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      throw Exception('Failed to create annonce.');
    }
  } catch (error) {
    // Handle any exceptions that might occur during the HTTP request.
    print('Error: $error');
    Fluttertoast.showToast(
      msg: "Failed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    throw Exception('Failed to create annonce.');
  }
}
Future <dynamic> fetchOffers()async{

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? token = prefs.getString('token');

  final response = await http.get(
    Uri.parse('$VPNURL/services'),
    headers: {
     // 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
    List<Offer> categories = jsonData.map((json) => Offer.fromJson(json)).toList();
    return categories;
  } else {
    throw Exception("Can't get the value");
  }

}