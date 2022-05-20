class User {
  String id;
  String uid;
  String name;
  String phone;
  List<String> roles;

  User(
      {required this.id,
      required this.name,
      required this.roles,
      required this.phone,
      required this.uid});

  factory User.fromJson(var json) {
    return User(
        id: json['id'],
        name: json['name'],
        roles: List.from(json['roles']),
        phone: json['phone'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "phone": phone,
      "roles": roles,
    };
  }
}
