class User {
  int? id; // Use int or String based on your requirements
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  List<Role>? roles;
  String? accessToken ;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.roles,
    this.accessToken
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      accessToken: json['accessToken'],
      roles: json['roles'] != null
          ? List<Role>.from(json['roles'].map((role) => Role.fromJson(role)))
          : null,
    );
  }


  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, email: $email, password: $password,accessToken: $accessToken, roles: $roles}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'accesToken': accessToken,
      'roles': roles?.map((role) => role.toJson()).toList(),
    };
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
