import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Model/offer/offer.dart';
import 'package:http/http.dart' as http;

import '../../Services/env.dart';
/*
class Search extends StatefulWidget {
  final List<Offer> allOffers;

  Search({required this.allOffers});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _searchController;
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _inputFiled2(
          title: 'Search',
          hint: 'Search for offers...',
          controller: _searchController,
          widget: DropdownButton<String>(
            value: _selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue ?? '';
              });
            },

          ),
        ),
        ElevatedButton(
          onPressed: () async {
            // Fetch offers based on the selected category
            List<Offer> filteredOffers = await getOffersByCategory(_selectedCategory);
            // Handle filteredOffers as needed
            print(filteredOffers);
          },
          child: Text('Search'),
        ),
      ],
    );
  }

  Widget _inputFiled2({
    required String title,
    required String hint,
    TextEditingController? controller,
    Widget? widget,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8,),
            padding: EdgeInsets.only(left: 14 ),
            child: Row(
              children: [
                Expanded(
                  child:TextFormField(
                    readOnly: widget==null?false:true,
                    decoration: InputDecoration(
                      hintText: hint,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                      ),
                    ),
                    controller: controller,
                    autofocus: false,
                    cursorColor:Colors.grey,
                  ) ,
                ),
                widget==null?Container():Container(child: widget!)
              ],
            ),
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          )
        ],
      ),
    );
  }

  Future<List<Offer>> getOffersByCategory(String categoryName) async {
    try {
      final response = await http.get(
        Uri.parse('$VPNURL/services/Category/$categoryName'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data = json.decode(utf8.decode(response.bodyBytes));
        List<Offer> offers = data.map((offerMap) => Offer.fromJson(offerMap)).toList();
        return offers;
      } else {
        throw Exception('Failed to load offers for the category');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception("Can't get offers for the category");
    }
  }
}*/
