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
  String value;
  String format;
  double price;
  String imgUrl;
  Product({
    required this.id,
    required this.name,
    required this.value,
    required this.format,
    required this.price,
    required this.imgUrl,
  });

  factory Product.fromJson(var json) {
    return Product(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      format: json['format'],
      price: json['price'],
      imgUrl: json['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "value": value,
      "format": format,
      "price": price,
      "imgUrl": imgUrl
    };
  }
}
