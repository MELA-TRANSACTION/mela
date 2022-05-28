import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/trans.dart';
import 'package:mela/screens/recharge/recharge_basket_screen.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Mes produits"),
      ),
      body: BlocBuilder<TransBloc, TransState>(
        builder: (context, state) {
          if (state is TransStateSuccess) {
            if (state.trans.isEmpty) {
              return const Center(
                child: Text("Pas des produits"),
              );
            }

            var products = getProducts(state.trans);
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 7 / 9,
              ),
              itemCount: products.length,
              padding: const EdgeInsets.only(
                right: 8,
                left: 8,
                top: 16,
                bottom: 120,
              ),
              itemBuilder: (context, index) {
                Product product = products[index];

                return ProdBasketTile(
                  product: product,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            RechargeBasketScreen(product: product),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const Center(
            child: Text("Loading ..."),
          );
        },
      ),
    );
  }

  List<Product> getProducts(List<Trans> t) {
    List<Product> p = [];
    var product;

    for (var n in t) {
      if (n.status == "SEND") {
        product = n.product.copyWith(
          quantity: n.quantity,
        );
        p.add(product);
      }

      if (n.status == "RECEIVE") {
        product = n.product.copyWith(
          quantity: n.quantity,
        );
        p.add(product);
      }
    }

    return p;
  }
}
