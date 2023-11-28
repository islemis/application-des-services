import 'package:flutter/material.dart';
import 'package:untitled5/Model/offer/offer.dart';

import '../User/registration_page.dart';
import '../component/offer/OfferDetailsPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F6E9), // Couleur beige plus claire
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(secondary: Colors.teal),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Service',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.teal[700], // Couleur verte pour le texte de l'appbar
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset(
              'assets/logo.png', // Remplacez par le chemin de votre image de logo
              height: 30, // Ajustez la hauteur selon vos besoins
            ),
          ),
        ],
        backgroundColor: Colors.white!, // Couleur bleue claire pour l'arrière-plan de l'appbar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[200], // Couleur de fond de la barre de recherche
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.white, // Couleur de l'icône de recherche
                    onPressed: () {
                      showSearch(
                        context: context,
                     //   delegate: OfferSearch(offers),
                      );
                    },
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white, // Couleur du texte dans le champ de recherche
                      ),
                      decoration: InputDecoration(
                        hintText: 'Rechercher...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.white70, // Couleur du texte d'indice dans le champ de recherche
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.green[100], // Couleur de fond de la bande publicitaire
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FLASH OFFERS',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[300],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 120.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/logo.png',
                                  fit: BoxFit.cover,
                                  height: 70.0,
                                  width: 80.0,
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  "formation ",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OfferDetailsPage(),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                     /*   Image.asset(
                          '${offers[index].imageUrl}',
                          fit: BoxFit.cover,
                          height: 120.0,
                        ),*/
                        SizedBox(height: 8.0),
                        Text(
                         "test ",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "description",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.green[700], // Couleur verte pour l'élément sélectionné dans la barre de navigation inférieure
        unselectedItemColor: Colors.blue[500], // Couleur bleue pour les éléments non sélectionnés dans la barre de navigation inférieure
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationPage()),
            );
          }
        },
      ),
    );
  }
}
