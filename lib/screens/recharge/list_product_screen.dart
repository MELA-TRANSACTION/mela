import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/product/product_bloc.dart';
import 'package:mela/models/product.dart';

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
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadSuccess) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text("Pas des produits"),
              );
            }
            return ListView.builder(
                itemCount: state.products.length,
                padding: const EdgeInsets.only(
                  right: 8,
                  left: 8,
                  top: 16,
                  bottom: 120,
                ),
                itemBuilder: (context, index) {
                  Product product = state.products[index];
                  return ProductTile(
                    product: product,
                  );
                });
          }

          return const Center(
            child: Text("Loading ..."),
          );
        },
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    required this.product,
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Color(0xff0c2359),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: const Color(0xff0e2763),
      margin: const EdgeInsets.only(top: 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${product.quantity}",
                  style: TextStyle(color: Colors.amber[700], fontSize: 24),
                ),
                SizedBox(
                  width: 24,
                  child: SvgPicture.asset(
                    "images/wine.svg",
                    height: 24,
                    width: 22,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product.name} ",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chevron_right,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
