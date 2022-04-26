import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mela/models/product.dart';

@immutable
class Basket extends Equatable {
  final List<Product> cartList;
  // int totalItems = 0;

  Basket() : cartList = <Product>[];

  Basket initBasket() {
    //totalItems = 0;
    cartList.clear();
    getTotalPrice();

    ///print("modern");
    return Basket();
  }

  Stream<List<Product>> returnCartList() async* {
    yield cartList;
  }

  Product changeItemCount(int index, bool isIncreased) {
    if (isIncreased) {
      cartList[index].quantity += 1;
      getItemCount(index);
      //totalItems++;
      return cartList[index];
    } else {
      if (getItemCount(index) > 1) {
        cartList[index].quantity -= 1;
        // totalItems--;
        getItemCount(index);
      }

      return cartList[index];
    }
  }

  double getItemCount(index) {
    return cartList[index].quantity;
  }

  num getTotalPrice() {
    num total = 0;

    for (int i = 0; i < cartList.length; i++) {
      total = total + (cartList[i].quantity * cartList[i].price);
    }

    return total;
  }

  void deleteItem(Product item) {
    cartList.remove(item);
    returnCartList();
  }

  Product addToCart(Product item) {
    bool found = false;
    //print(item.name);
    if (cartList.isEmpty) {
      cartList.add(item);
    } else {
      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i].name == item.name) {
          cartList[i].quantity += item.quantity;
          found = true;
        }
      }
      if (found == false) {
        cartList.add(item);
        // totalItems = totalItems + 1;
      }
    }
    return item;
  }

  @override
  List<Object> get props => [cartList];
}
