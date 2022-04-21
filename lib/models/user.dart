class User {
  String uid;
  String name;
  String phone;
  String role;

  User(
      {required this.name,
      required this.role,
      required this.phone,
      required this.uid});

  factory User.fromJson(var json) {
    return User(
        name: json['name'],
        role: json['role'],
        phone: json['phone'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "phone": phone,
      "role": role,
    };
  }
}
