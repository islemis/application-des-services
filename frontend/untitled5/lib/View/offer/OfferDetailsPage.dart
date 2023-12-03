import 'package:flutter/material.dart';
import '../../Model/offer/offer.dart';

class OfferDetailsPage extends StatelessWidget {
  final Offer offer;

  OfferDetailsPage({required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.titre ?? 'Offer Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display Images
                if (offer.images != null && offer.images!.isNotEmpty)
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/Image/${offer.images![0].name}'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                SizedBox(height: 16.0),
                // Display Offer Details
                Text(
                  'Title:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  offer.titre ?? 'No title available',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  offer.description ?? 'No description available',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Details:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  offer.details ?? 'No details available',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Address:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  offer.adresse ?? 'No address available',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Date:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  offer.date?.toString() ?? 'No date available',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Price:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${offer.price ?? 0}',
                  style: TextStyle(fontSize: 16),
                ),
                // Add more details as needed

                SizedBox(height: 16.0),
                // Apply Button or Action Button
                ElevatedButton(
                  onPressed: () {
                    // Handle button press, e.g., navigate to apply page
                  },
                  child: Text('Apply'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
