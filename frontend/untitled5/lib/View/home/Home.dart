import 'package:flutter/material.dart';
import 'package:untitled5/Model/offer/offer.dart';
import 'package:untitled5/View/component/NavBar.dart';
import 'package:untitled5/View/offer/CartOffre.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Services/Offer/OfferService.dart';
import '../component/SearchBarApp.dart';
import '../offer/OfferDetailsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F6E9),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
            .copyWith(secondary: Colors.teal),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  String category = "Plomberie";
  bool isFilteredByCategories = false;

  void setCategory(String ca) => setState(() {
    category = ca;
    isFilteredByCategories = true;
  });

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
            color: Colors.teal,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset(
              'assets/logo.png',
              height: 70,
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            child: SearchBarApp(setCategoryCallBack: setCategory),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: 210.0,
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
                    height: 160.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: urls.length,
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
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    images[index],
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
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<Offer> offers = snapshot.data as List<Offer>;

                  List<Offer> filteredOffers = offers;

                  if (isFilteredByCategories) {
                    filteredOffers = offers
                        .where((offer) =>
                        offer.category![0].name!.toLowerCase().startsWith(category.toLowerCase()))
                        .toList();
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: filteredOffers.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          Offer? offer = await getOfferById(filteredOffers[index].idService!.toInt());
                          if (offer != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OfferDetailsPage(offer: offer),
                              ),
                            );
                          }
                        },
                        child: CartOffre(offer: filteredOffers[index]),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
