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
            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: 72,
              ),
              itemCount: state.trans.length,
              itemBuilder: (context, index) {
                var products = getProductFromTrans(state.trans);

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

  List<Product> getProductFromTrans(List<Trans> trans) {
    List<Product> products = [];
    for (var t in trans) {
      products.add(t.product);
    }

    return products;
  }
}
