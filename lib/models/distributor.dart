class Distributor {
  String place;
  String address;
  String city;
  String name;
  String phone;

  Distributor({
    required this.place,
    required this.city,
    required this.address,
    required this.name,
    required this.phone,
  });

  factory Distributor.fromJson(var json) {
    return Distributor(
        place: json['place'] ?? "Inconnue",
        name: json['name'] ?? "inconnue",
        address: json['address'] ?? "inconnue",
        city: json['city'] ?? "inconnue",
        phone: json['phone']);
  }
}
