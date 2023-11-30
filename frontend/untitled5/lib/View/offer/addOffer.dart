import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'dart:io'; // Import the dart:io package
import 'package:fluttertoast/fluttertoast.dart'; // Import the fluttertoast package
import 'package:http/http.dart' as http;
import 'package:untitled5/Services/Offer/OfferService.dart';

import '../../Model/offer/Category.dart';

class AddOfferScreen extends StatelessWidget {
  AddOfferScreen({super.key});

  final TextEditingController nomServiceController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  List<File> listimage = []; // Use File type for the list of images


  final List<Category> categories = [
    Category(id: 1, name: 'Category 1'),
    Category(id: 2, name: 'Category 2'),
    // Add more categories as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajout De Service',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: nomServiceController,
                labelText: 'Nom Service',
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: adresseController,
                labelText: 'Adresse',
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: prixController,
                labelText: 'Prix',
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: descriptionController,
                labelText: 'Description du Service',
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: detailsController,
                labelText: 'Détails du Service',
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () async {
                  final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery)  ;
                  if (pickedFile != null) {
                    listimage.add(File(pickedFile.path));
                  }
                },
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Espace pour l\'upload d\'image',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                //  double prix = double.parse(prixController.text);
                  await addOffre(
                   " nomServiceController.text",
                 "   detailsController.text",
                "    adresseController.text",
                   33 ,
                  "  descriptionController.text",

                  );
                  // Add logic for submitting the service addition form
                },
                child: Text(
                  'Ajouter le Service',
                  style: TextStyle(fontSize: 16.0,color: Colors.white),

                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal[400],
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }
}