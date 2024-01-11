


import '../images.dart';
import '../user.dart';
import 'Category.dart';
class Offer {
  int? idOffre;
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
      {this.idOffre,
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
    idOffre = json['idOffre'];
    adresse = json['adresse'];
    if (json['date'] != null) {
      date = DateTime.fromMillisecondsSinceEpoch(json['date']);
    }
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

      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idOffre'] = this.idOffre;
    data['adresse'] = this.adresse;
    if (this.date != null) {
      data['date'] = this.date!.millisecondsSinceEpoch;
    }   
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

