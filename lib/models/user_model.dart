  class UserModel {
    final int? id;
    final String name;
    final String email;
    final String phone;
    final String password;

    UserModel({
      this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.password,
    });
    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      };
    }

    factory UserModel.fromMap(Map<String, dynamic> map) {
      return UserModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        phone: map['phone'],
        password: map['password'],
      );
    }
  }
