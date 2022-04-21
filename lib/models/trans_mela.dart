class TransMela {
  int? createdAt;
  late int amount;
  late int quantity;
  late int cost;
  late String typeTrans;
  Company? company;
  late int id;
  Distributor? distributor;
  late int localPrice;
  Products? products;

  TransMela(
      {this.createdAt,
      required this.amount,
      required this.quantity,
      required this.cost,
      required this.typeTrans,
      this.company,
      required this.id,
      this.distributor,
      required this.localPrice,
      this.products});

  TransMela.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    amount = json['amount'];
    quantity = json['quantity'];
    cost = json['cost'];
    typeTrans = json['typeTrans'];
    if (json['company'] != null) {
      company = Company.fromJson(json['company']);
    } else {
      company = null;
    }
    id = json['id'];
    distributor = json['distributor'] != null
        ? Distributor.fromJson(json['distributor'])
        : null;
    localPrice = json['localPrice'];
    products =
        json['products'] != null ? Products.fromJson(json['products']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['amount'] = amount;
    data['quantity'] = quantity;
    data['cost'] = cost;
    data['typeTrans'] = typeTrans;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['id'] = id;
    if (distributor != null) {
      data['distributor'] = distributor!.toJson();
    }
    data['localPrice'] = localPrice;
    if (products != null) {
      data['products'] = products!.toJson();
    }
    return data;
  }
}

class Company {
  String? uid;
  String? phone;

  Company({this.uid, this.phone});

  Company.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['phone'] = phone;
    return data;
  }
}

class Distributor {
  String? uid;
  String? phone;
  String? name;

  Distributor({this.uid, this.phone, this.name});

  Distributor.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['phone'] = phone;
    data['name'] = name;
    return data;
  }
}

class Products {
  int? quantity;
  int? price;
  String? name;
  String? id;

  Products({this.quantity, this.price, this.name, this.id});

  Products.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    price = json['price'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['price'] = price;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
