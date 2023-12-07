import 'package:flutter/material.dart';
import '../../Model/offer/offer.dart';
import '../offer/CartOffre.dart';
import '../../Services/Offer/OfferService.dart';
import '../offer/OfferDetailsPage.dart';

class OfferListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: fetchOffersUser(),
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

            return ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OfferDetailsPage(offer: offers[index]),
                      ),
                    );
                  },
                  child: CartOffre(offer: offers[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
