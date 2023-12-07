

import 'package:untitled5/Model/offer/Category.dart';

import '../images.dart';
import '../user.dart';
class Offer {
  int? idService;
  String? adresse;
  DateTime? date;
  String? details;
  String? description;
  double? price;
  String? titre;
  List<Images>? images;
  User? user;
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
        this.user,
        this.category
  });
  Offer.fromJson(Map<String, dynamic> json) {
    idService = json['idService'];
    adresse = json['adresse'];
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
    details = json['details'];
    description = json['description'];
    price = json['price'] != null ? double.parse(json['price'].toString()) : null;
    titre = json['titre'];

    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }

    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
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

    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.category != null) {
      data['categories'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

