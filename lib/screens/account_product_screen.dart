import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      // body: BlocBuilder<AccountBloc, AccountState>(
      //   builder: (context, state) {
      //     if (state is AccountLoadSuccess) {
      //       if (state.products.isEmpty) {
      //         return const Center(
      //           child: Text("Balance vide"),
      //         );
      //       }
      //       return ListView.builder(
      //         padding: const EdgeInsets.only(
      //           left: 16,
      //           right: 16,
      //           top: 24,
      //           bottom: 72,
      //         ),
      //         itemCount: 4,
      //         itemBuilder: (context, index) {
      //           return AccountProductTile(
      //             product: state.products[index],
      //           );
      //         },
      //       );
      //     }
      //     if (state is AccountLoadFailure) {
      //       return const Center(
      //         child: Text("Error"),
      //       );
      //     }
      //
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }
}

class AccountProductTile extends StatelessWidget {
  const AccountProductTile({
    required this.product,
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(top: 0.8),
      child: ListTile(
        leading: SvgPicture.asset(
          "images/wine.svg",
          height: 44,
          width: 40,
        ),
        title: Text(product.name),
        subtitle: Text(product.format),
        trailing: Text(product.quantity.toString()),
      ),
    );
  }
}
