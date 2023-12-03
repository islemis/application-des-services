import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:untitled5/Model/offer/Category.dart';
class Offer {
  int? idService;
  String? adresse;
  DateTime? date;
  String? details;
  String? description;
  double? price;
  String? titre;
  List<Images>? images;
  //User? user;
  List<Category>? category;

  Offer(
      {this.idService,
        this.adresse,
        this.date,
        this.details,
        this.description,
        this.price,
        this.titre,
        this.images,
        //this.user,
        this.category
  });

  Offer.fromJson(Map<String, dynamic> json) {
    idService = json['idService'];
    adresse = json['adresse'];
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
    details = json['details'];
    description = json['description'];
    price = json['price'] != null ? double.parse(json['price'].toString()) : null; // Parse as double
    titre = json['titre'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }

  /*  user = json['user'] != null ? new User.fromJson(json['user']) : null; */
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idService'] = this.idService;
    data['adresse'] = this.adresse;
    data['date'] = this.date;
    data['details'] = this.details;
    data['description'] = this.description;
    data['price'] = this.price;
    data['titre'] = this.titre;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    /*
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }*/
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? name;
  String? type;
  String? imagePath; // Change this field to match Spring class
  Uint8List? url; // Change this field to match Spring class

  Images({this.id, this.name, this.type, this.imagePath, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    imagePath = json['imagePath'];
    if (json['url'] != null) {
      url = Uint8List.fromList(base64.decode(json['url']));
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['imagePath'] = this.imagePath;
    data['url'] =
        base64.encode(this.url!); // Encode the Uint8List as a base64 string

    return data;
  }
}