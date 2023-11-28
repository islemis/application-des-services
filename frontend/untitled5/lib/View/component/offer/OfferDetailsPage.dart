import 'package:flutter/material.dart';


import '../../../Model/offer/offer.dart';

class OfferDetailsPage extends StatelessWidget {
  final Offer? offer;

  OfferDetailsPage({ this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer!.titre!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
           /* Image.asset(
              'assets/Image/${offer.}',
              width: 250,
              height: 150,
            ),*/
            SizedBox(width: 16.0), // Espace entre l'image et la description
            // Description et bouton "Postuler"
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text(
                    offer!.description!,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 16.0), // Espacement entre la description et le bouton
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
