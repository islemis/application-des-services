
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
Null?accessToken ;
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
