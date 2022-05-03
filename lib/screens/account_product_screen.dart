import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/account/account_bloc.dart';
import 'package:mela/blocs/product/product_bloc.dart';
import 'package:mela/components/product_tile.dart';

import 'package:mela/models/product.dart';

class AccountProductScreen extends StatelessWidget {
  const AccountProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: const [],
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoadSuccess) {
            if (state.products.isEmpty) {
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
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductTile(
                  product: state.products[index],
                );
              },
            );
          }
          if (state is ProductLoadFailure) {
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
}
