import 'package:flutter/material.dart';

import '../../../Services/user/UserService.dart';
import '../../User/Login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Index of the current tab

  final List<Widget> _pages = [
    // Add other pages here if necessary
    // For example, you can add another page like HomePageContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'), // Display the title of the current page
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(8.0), // Border radius
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    icon: Icon(Icons.search),
                    border: InputBorder.none, // Remove the default border of TextField
                  ),
                  onChanged: (query) {
                    // Add real-time search logic here
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _pages.isEmpty
                ? Center(
              child: Text('Home Page Content'),
            )
                : _pages[_currentIndex], // Display the page corresponding to the current tab
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            // Logout button tapped
            logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else {
            setState(() {
              _currentIndex = index; // Update the index of the current tab when tapped
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
