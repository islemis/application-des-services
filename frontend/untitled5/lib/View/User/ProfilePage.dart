import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../Model/user.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? firstImageBytes = widget.user!.images?[0].url;

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
            _isEditing
                ? TextFormField(
              // Assuming user.images is a list of Uint8List
              initialValue:
              widget.user.images?.isNotEmpty == true ? '' : '',
              onChanged: (value) {
                // Handle image upload or modification logic
              },
            )
                : Image.memory(
              firstImageBytes!,
              fit: BoxFit.cover,
              height: 70.0,
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
          ],
        ),
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
        onPressed: () {
          // Save changes
          setState(() {
            widget.user.firstName = _firstNameController.text;
            widget.user.lastName = _lastNameController.text;
            widget.user.adresseDomicile = _adresseDomicileController.text;
            widget.user.adresseTravail = _adresseTravailController.text;
            widget.user.tel = _telController.text;
            _isEditing = false;
          });
        },
        child: Icon(Icons.save),
      )
          : null,
    );
  }
}
