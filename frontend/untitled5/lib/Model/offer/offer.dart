import 'dart:ffi';

import 'package:untitled5/Model/offer/Category.dart';

class Offer {
  int? idService;
  String? adresse;
  Null? date;
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
        this.category});

  Offer.fromJson(Map<String, dynamic> json) {
    idService = json['idService'];
    adresse = json['adresse'];
    date = json['date'];
    details = json['details'];
    description = json['description'];
    price = json['price'];
    titre = json['titre'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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

  Images({this.id, this.name, this.type});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  Null? adresseTravail;
  Null? adresseDomicile;
  Null? diplome;
  Null? tel;
  Null? password;
  String? email;
  String? lastName;
  Null? category;
  Null? images;
  Null? profileImage;

  User(
      {this.id,
        this.firstName,
        this.adresseTravail,
        this.adresseDomicile,
        this.diplome,
        this.tel,
        this.password,
        this.email,
        this.lastName,
        this.category,
        this.images,
        this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    adresseTravail = json['adresseTravail'];
    adresseDomicile = json['adresseDomicile'];
    diplome = json['diplome'];
    tel = json['tel'];
    password = json['password'];
    email = json['email'];
    lastName = json['lastName'];
    category = json['category'];
    images = json['images'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['adresseTravail'] = this.adresseTravail;
    data['adresseDomicile'] = this.adresseDomicile;
    data['diplome'] = this.diplome;
    data['tel'] = this.tel;
    data['password'] = this.password;
    data['email'] = this.email;
    data['lastName'] = this.lastName;
    data['category'] = this.category;
    data['images'] = this.images;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

