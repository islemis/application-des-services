



import 'package:flutter/material.dart';

import '../../Model/offer/offer.dart';

class CartOffre extends StatefulWidget {
  final Offer? offer;
  const CartOffre({super.key,this.offer});

  @override
  State<CartOffre> createState() => _CartOffreState();
}

class _CartOffreState extends State<CartOffre> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                          height: 120.0,
                        ),
          SizedBox(height: 8.0),
          Text(
            widget.offer!.titre!??"",
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
    );
  }
}
