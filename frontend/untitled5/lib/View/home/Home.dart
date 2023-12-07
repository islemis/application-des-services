import 'package:flutter/material.dart';
import 'package:untitled5/Model/offer/offer.dart';
import 'package:untitled5/View/component/NavBar.dart';
import 'package:untitled5/View/offer/CartOffre.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Services/Offer/OfferService.dart';
import '../offer/OfferDetailsPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F6E9), // Couleur beige plus claire

        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
            .copyWith(secondary: Colors.teal),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  List<String> urls = [
    'https://brico-direct.tn/',
    'https://www.astral.tn/fr',
    'https://www.boutique.bencheikhgarden.tn/'
  ];
  List<String> images = [
    'assets/brico1.jpeg',
    'assets/astral.jpeg',
    'assets/garden.png',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'ServiceConnect',
            style: TextStyle(
              fontFamily: 'Times New Roman',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal, // Couleur verte pour le texte de l'appbar
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset(
                'assets/logo.png',
                // Remplacez par le chemin de votre image de logo
                height: 70, // Ajustez la hauteur selon vos besoins
              ),
            ),
          ],
          backgroundColor: Colors
              .white!, // Couleur bleue claire pour l'arrière-plan de l'appbar
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Couleur de fond de la barre de recherche
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.grey, // Couleur de l'icône de recherche
                      onPressed: () {
                        /* showSearch(
                        context: context,
                       delegate: OfferSearch(offers),
                      );*/
                      },
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black, // Couleur du texte dans le champ de recherche
                        ),
                        decoration: InputDecoration(
                          hintText: 'Rechercher...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey, // Couleur du texte d'indice dans le champ de recherche
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 250.0,
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // Couleur de fond de la bande publicitaire
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Annonces',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      height: 158.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: urls.length, // Use the length of the URLs list
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (index < urls.length) {
                                  launch(urls[index]);
                                }
                              },
                              child: Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      images[index], // Use the correct index for images
                                      height: 130.0,
                                      width: 150.0,
                                    ),
                                    SizedBox(height: 4.0),
                                  ],
                                ),
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
                child: FutureBuilder(
                    future: fetchOffers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child:
                          CircularProgressIndicator(), // Show a loading indicator
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                              'Error: ${snapshot.error}'), // Show error if any
                        );
                      } else {
                        List<Offer> offers = snapshot.data as List<Offer>;

                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: offers.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                            Offer? offer= await getOfferById(offers[index].idService!.toInt());
                                print("helloo");
                                print(offers[index].images?[0].name);
                            if (offer != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OfferDetailsPage(offer: offer),
                                ),
                              );
                            }

                              },
                              child: CartOffre(offer: offers[index]),
                            );
                          },
                        );
                      }
                    })),
          ],
        ),
        bottomNavigationBar: NavBar()
    );
  }
}