import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/Model/offer/offer.dart';
import '../../Model/user.dart';
import '../../Services/Offer/OfferService.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _adresseDomicileController;
  late TextEditingController _adresseTravailController;
  late TextEditingController _telController;
  bool _isEditing = false;
  File? _profileImage;
  List<File?> _workImages = [];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _adresseDomicileController =
        TextEditingController(text: widget.user.adresseDomicile ?? '');
    _adresseTravailController =
        TextEditingController(text: widget.user.adresseTravail ?? '');
    _telController = TextEditingController(text: widget.user.tel ?? '');

    // Initialize work-related images
    for (var image in widget.user.images!.skip(1)) {
      _workImages.add(null);
    }
  }

  Future<void> _pickImage(bool isProfileImage, int index) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        if (isProfileImage) {
          _profileImage = File(pickedImage.path);
        } else {
          _workImages[index] = File(pickedImage.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),

        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display profile image
            CircleAvatar(
              radius: 70.0,
              backgroundImage:
                   MemoryImage(widget.user.images![0].url!),
            ),
            SizedBox(height: 16.0),
            // Other user details
            Text('Prénom:'),
            _isEditing
                ? TextField(
              controller: _firstNameController,
            )
                : Text(widget.user.firstName.toString()),
            SizedBox(height: 16.0),
            Text('Nom:'),
            _isEditing
                ? TextField(
              controller: _lastNameController,
            )
                : Text(widget.user.lastName.toString()),
            SizedBox(height: 16.0),
            Text('Adresse Domicile:'),
            _isEditing
                ? TextField(
              controller: _adresseDomicileController,
            )
                : Text(widget.user.adresseDomicile.toString()),
            SizedBox(height: 16.0),
            Text('Adresse Travail:'),
            _isEditing
                ? TextField(
              controller: _adresseTravailController,
            )
                : Text(widget.user.adresseTravail.toString()),
            SizedBox(height: 16.0),
            Text('Téléphone:'),
            _isEditing
                ? TextField(
              controller: _telController,
            )
                : Text(widget.user.tel.toString()),
            SizedBox(height: 16.0),
            // Display work-related images
            if (widget.user.images!.length > 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Photos de travail:'),
                  SizedBox(height: 8.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        _workImages.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () => _pickImage(false, index),
                            child: _workImages[index] != null
                                ? Image.file(
                              _workImages[index]!,
                              fit: BoxFit.cover,
                              height: 70.0,
                            )
                                : Image.memory(
                              widget.user.images![index + 1].url!,
                              fit: BoxFit.cover,
                              height: 70.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
        onPressed: () {
          // Save changes logic here, including updating profile image and work-related images
          setState(() {
            widget.user.firstName = _firstNameController.text;
            widget.user.lastName = _lastNameController.text;
            widget.user.adresseDomicile = _adresseDomicileController.text;
            widget.user.adresseTravail = _adresseTravailController.text;
            widget.user.tel = _telController.text;
          });
        },
        child: Icon(Icons.save),
      )
          : null,
    );
  }
}
