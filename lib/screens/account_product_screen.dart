import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/components/product_tile.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/trans.dart';

class AccountProductScreen extends StatelessWidget {
  const AccountProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: const [],
      ),
      body: BlocBuilder<TransBloc, TransState>(
        builder: (context, state) {
          if (state is TransStateSuccess) {
            if (state.trans.isEmpty) {
              return const Center(
                child: Text("Balance vide"),
              );
            }
            var products = getProducts(state.trans);
            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: 72,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductTile(
                  product: products[index],
                );
              },
            );
          }
          if (state is TransStateFailure) {
            return const Center(
              child: Text("Error"),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Product> getProducts(List<Trans> t) {
    List<Product> p = [];
    for (var n in t) {
      if (n.status == "RECEIVE") {
        p.add(
          n.product.copyWith(
            quantity: n.quantityOut == 0 ? n.quantityIn : n.quantityOut,
          ),
        );
      }
    }
    return p;
  }
}
