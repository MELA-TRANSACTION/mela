class Distributor {
  List<String> roles;
  String address;
  String city;
  String name;
  String phone;

  Distributor({
    required this.roles,
    required this.city,
    required this.address,
    required this.name,
    required this.phone,
  });

  factory Distributor.fromJson(var json) {
    return Distributor(
        roles: List.from(json['roles']),
        name: json['name'] ?? "inconnue",
        address: json['address'] ?? "inconnue",
        city: json['city'] ?? "inconnue",
        phone: json['phone']);
  }
}
