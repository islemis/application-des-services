

import 'package:flutter/material.dart';

import '../offer/addOffer.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
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
      ],
      selectedItemColor: Colors.green[700],
      // Couleur verte pour l'élément sélectionné dans la barre de navigation inférieure
      unselectedItemColor: Colors.blue[500],
      // Couleur bleue pour les éléments non sélectionnés dans la barre de navigation inférieure
      onTap: (int index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddOfferScreen()),
          );
        }
      },
    );
  }
}
