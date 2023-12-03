import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import the package
import 'package:untitled5/Services/env.dart';

import '../../Model/offer/offer.dart';

Future<void> addOffre(String titre, String details, String address, double prix, String description  , List<File> files   ) async {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage(); // Initialize the instance

  String? email = await secureStorage.read(key: 'email');
  String? password = await secureStorage.read(key: 'password');

  try {
    //String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));

    var request = http.MultipartRequest('POST', Uri.parse(VPNURL + 'services/addService'));
    request.headers['Content-Type'] = 'multipart/form-data';

    /* ..headers['Authorization'] = basicAuth  // Fix headers assignment
      ..headers['Accept'] = 'application/json';*/

    // Add form fields
    request.fields.addAll({
      'service': jsonEncode({
        "titre": titre,
        "price": prix,
        "description": description,
        "details": details,
        "adresse": address,
        // Add other fields if needed
      }),
    });

    // Add images

    for (var i = 0; i < files.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        files[i].path,
      ));
    }

    // Send the request
    http.StreamedResponse response = await request.send();
    print('Number of images: ${files.length}');

    print(request);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server returns a 201 CREATED or 200 OK response, handle the success here.
      // You might want to parse the response if the server sends any meaningful data.
      Fluttertoast.showToast(
        msg: "Success",
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
      print('Failed with status code: ${response.statusCode}');
      print('Failed with: ${request.fields}');

      Fluttertoast.showToast(
        msg: "Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    }
  } catch (error) {
    // Handle any exceptions that might occur during the HTTP request.
    print('ErroriSLEM: $error');
    if (error is http.Response) {
      print('Response body BERICHE: ${error.body}');
    }


    throw Exception('Failed to create annonce.');
  }
}

//getalloffers
Future <List<Offer>> fetchOffers()async{

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? token = prefs.getString('token');

  final response = await http.get(
    Uri.parse(VPNURL+'services'),
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









Future<Offer?> getOfferById(int offerId) async {
  try {
    final response = await http.get(
      Uri.parse(VPNURL + 'services/$offerId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      dynamic jsonData = json.decode(utf8.decode(response.bodyBytes));
      Offer offer = Offer.fromJson(jsonData);
      return offer;
    } else {
      throw Exception("Can't get the offer");
    }
  } catch (error) {
    print('Error: $error');
    throw Exception("Can't get the offer");
  }
}