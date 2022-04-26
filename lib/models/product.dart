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
  double quantity;
  String format;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.format,
    required this.price,
  });

  factory Product.fromJson(var json) {
    print(json);
    return Product(
      id: json['id'],
      name: json['name'],
      quantity: double.parse(json['quantity'].toString()),
      format: json['format'] ?? "",
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "quantity": quantity,
      "format": format,
      "price": price,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    double? quantity,
    String? format,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      format: format ?? this.format,
      price: price ?? this.price,
    );
  }
}
