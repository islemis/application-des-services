import 'package:flutter/material.dart';

import '../../Model/user.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {
    // Create a User object with the entered values
    User newUser = User(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    // Add your registration logic here, e.g., send the user data to a server
    print('User Registered: ${newUser.firstName} ${newUser.lastName}, ${newUser.email}, ${newUser.password}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: Container(
        color: Colors.teal,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
              'Inscription',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal, // Change the text color to teal
                    ),
                  ),
                  TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: 'Prénom'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: 'Nom'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Mot de passe'),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal, // Utilisez la même couleur que la page de connexion
                    ),
                    child: Text('S\'inscrire'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
