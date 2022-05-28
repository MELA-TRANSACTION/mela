class Product {
  String id;
  String name;
  int? quantity;
  String format;
  double price;
  String ref;
  String typeTrans;

  Product(
      {required this.id,
      required this.name,
      this.quantity,
      required this.format,
      required this.price,
      required this.ref,
      required this.typeTrans});

  factory Product.fromJson(var json) {
    //print(json);
    return Product(
      id: json['id'].toString(),
      ref: json['ref'] ?? "",
      typeTrans: json['typeTrans'] ?? "",
      quantity: json['quantity'],
      name: json['name'],
      format: json['format'] ?? "",
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "format": format,
      "price": price,
      "quantity": quantity,
      "ref": ref,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? format,
    double? price,
    int? quantity,
    String? typeTrans,
    String? ref,
  }) {
    return Product(
      typeTrans: typeTrans ?? this.typeTrans,
      ref: ref ?? this.ref,
      id: id ?? this.id,
      name: name ?? this.name,
      format: format ?? this.format,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
