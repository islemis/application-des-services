
import 'images.dart';
import 'offer/Category.dart';

class User {
  int? id;
  String? firstName;
  String? adresseTravail;
  String? adresseDomicile;
  String? diplome;
  String? tel;
  String? password;
  String? email;
  String? lastName;
  List<Category>? category;
  List<Images>? images;
  String?accessToken ;
  Role? role ;
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
        this.role,
        this.accessToken,
        });

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
    if (json['category'] != null) {
      category = (json['category'] as List<dynamic>)
          .map((category) => Category.fromJson(category))
          .toList();
    }
    if (json['images'] != null) {
      images = (json['images'] as List<dynamic>)
          .map((images) => Images.fromJson(images))
          .toList();
    }
    role=json['role'];
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
    data['role']=this.role;
    return data;
  }
}



class Role {
  int? id;
  String? roleName;

  Role({
    this.id,
    this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      roleName: json['role_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_name': roleName,
    };
  }
}
