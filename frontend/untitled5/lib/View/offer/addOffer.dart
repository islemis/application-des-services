import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled5/Services/Offer/OfferService.dart';

import '../../Model/offer/Category.dart';

class AddOfferScreen extends StatefulWidget {
  @override
  _AddOfferScreenState createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  final TextEditingController nomServiceController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  List<File> listimage = [];

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
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _buildImageList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  double? prixValue = double.tryParse(prixController.text);

                  await addOffre(
                    nomServiceController.text,
                    detailsController.text,
                    adresseController.text,
                    prixValue!,
                    descriptionController.text,
                    listimage,
                  );
                  // Add logic for submitting the service addition form
                },
                child: Text(
                  'Ajouter le Service',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
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

  Widget _buildImageList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listimage.length + 1,
      itemBuilder: (context, index) {
        if (index == listimage.length) {
          return GestureDetector(
            onTap: () async {
              if (listimage.length < 4) {
                final pickedFiles = await ImagePicker().pickMultiImage(
                  imageQuality: 70,
                  maxWidth: 1440,
                );

                if (pickedFiles != null) {
                  setState(() {
                    listimage.addAll(
                      pickedFiles.map((pickedFile) => File(pickedFile.path)),
                    );
                  });
                }
              }
            },
            child: Container(
              width: 150.0,
              height: 150.0,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.add, size: 50.0, color: Colors.grey),
            ),
          );
        } else {
          return Stack(
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: FileImage(listimage[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      listimage.removeAt(index);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    color: Colors.grey,
                    child: Icon(Icons.close, color: Colors.white,size: 20.0,),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
