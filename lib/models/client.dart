class Client {
  String uid;
  String name;
  String phone;

  Client({required this.name, required this.uid, required this.phone});

  factory Client.fromJson(var json) {
    return Client(name: json['name'], uid: json['uid'], phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "phone": phone,
    };
  }
}
