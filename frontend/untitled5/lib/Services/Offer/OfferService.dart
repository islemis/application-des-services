import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<void> addOffre( titre, categoriename, details, address, List images, prix, description,idcategorie) async {
  var VPNURL = 'your_vpn_url'; // Replace with your VPN URL

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