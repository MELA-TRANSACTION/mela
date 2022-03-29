class User {
  String uid;
  String name;
  String phone;

  User({required this.name, required this.phone, required this.uid});

  factory User.fromJson(var json) {
    return User(name: json['name'], phone: json['phone'], uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "phone": phone,
    };
  }
}
