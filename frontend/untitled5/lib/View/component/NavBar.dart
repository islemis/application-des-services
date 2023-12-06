import 'package:flutter/material.dart';
import 'package:untitled5/View/User/Login.dart';
import '../../Model/user.dart';
import '../../Services/user/UserService.dart';
import '../User/ProfilePage.dart';
import '../offer/OfferListWidget.dart';
import '../offer/addOffer.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}
class _NavBarState extends State<NavBar> {
  Future<void> _onItemTapped(int index, BuildContext context) async {
    try {

       if (index == 1) {
        // Show the navigation menu for "Profil" options
        showNavigationMenu(context);
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
          icon: Icon(Icons.person),
          label: 'Profil',
        ),

      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.teal,
      onTap: (index) => _onItemTapped(index, context),
    );
  }

  void showNavigationMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Editer Mon Profil'),

              onTap: () async {
                User user = await getUserByEmail();

                Navigator.pop(context); // Close the menu

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(user:user),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Mes Offres'),
              onTap: () {
                Navigator.pop(context); // Close the menu
                // Navigate to Mes Offres page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OfferListWidget(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Ajouter Offre'),
              onTap: () {

                Navigator.pop(context); // Close the menu
                // Navigate to Ajouter Offre page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddOfferScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('déconnexion'),
              onTap: () {

                Navigator.pop(context); // Close the menu
                logout();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),


          ],
        );
      },
    );
  }
}
