class Account {
  double balance;
  double share;
  List<Product> products;

  Account({required this.share, required this.products, required this.balance});

  factory Account.fromJson(var json) {
    return Account(
        share: json['share'],
        products: json['products'],
        balance: json['balance']);
  }
}

class Product {
  String id;
  String name;
  int quantity;
  String format;
  double price;

  Product({
    required this.id,
    required this.name,
    this.quantity = 0,
    required this.format,
    required this.price,
  });

  factory Product.fromJson(var json) {
    print(json);
    return Product(
      id: json['id'].toString(),
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
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? format,
    double? price,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      format: format ?? this.format,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
