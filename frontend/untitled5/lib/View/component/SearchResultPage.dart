import 'package:flutter/material.dart';
import '../../Model/offer/offer.dart';
import '../../Services/Offer/OfferService.dart';
import '../offer/CartOffre.dart';
import '../offer/OfferDetailsPage.dart';

class SearchResultPage extends StatelessWidget {
  final List<Offer> searchResults;

  SearchResultPage({required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              Offer? offer = await getOfferById(searchResults[index].idService!.toInt());
              if (offer != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OfferDetailsPage(offer: offer),
                  ),
                );
              }
            },
            child: CartOffre(offer: searchResults[index]),
          );
        },
      ),
    );
  }
}
