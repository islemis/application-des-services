import 'package:flutter/material.dart';
import 'package:untitled5/View/User/Login.dart';
import '../../Model/user.dart';
import '../../Services/user/UserService.dart';
import '../User/ProfilePage.dart';
import '../offer/addOffer.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  Future<void> _onItemTapped(int index, BuildContext context) async {
try{
  print('Tapped index: $index');


    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddOfferScreen()),
      );
    }
    else if (index ==2)   {
      print('Fetching user data...');
      User user = await getUserByEmail();
      print('Retrieved user: $user');
      print('Navigating to ProfilePage');

      Navigator.push(

        context,

      MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
      );
    }
    else if (index ==3)   {
      logout();
      Navigator.push(

        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
} catch (e) {
  print('Error: $e');
  // Handle the error, e.g., show a toast or navigate to an error page.
}
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Ajouter',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.exit_to_app), // Icon for the logout button
          label: 'Déconnexion', // Label for the logout button
        )
      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.teal,
      onTap: (index) => _onItemTapped(index, context),
    );
  }
}
