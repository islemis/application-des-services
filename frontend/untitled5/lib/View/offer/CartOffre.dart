import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../Model/offer/offer.dart';

class CartOffre extends StatefulWidget {
  final Offer? offer;

  const CartOffre({Key? key, this.offer}) : super(key: key);

  @override
  State<CartOffre> createState() => _CartOffreState();
}

class _CartOffreState extends State<CartOffre> {
  @override
  Widget build(BuildContext context) {
    Uint8List? firstImageBytes = widget.offer!.images?[0].url;
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          if (firstImageBytes != null)
            Image.memory(
              firstImageBytes,
              fit: BoxFit.cover,
              height: 70.0,
            ),
          SizedBox(height: 8.0),
          Text(
            widget.offer?.titre ?? "",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            "à partir de" + (widget.offer?.price?.toString() ?? ""),
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
