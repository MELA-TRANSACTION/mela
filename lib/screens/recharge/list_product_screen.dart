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

  showBott(BuildContext context, Product product) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(bottom: 24),
          color: Colors.white,
          child: Form(
            child: Column(
              children: [
                Container(
                  height: 64,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.orange,
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white70,
                      ),
                    ),
                    title: const Text(
                      "produit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                    subtitle: Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: Text(
                      "${product.format} \$",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // if (_globalKey.currentState!.validate()) {
                          //   _globalKey.currentState!.save();
                          //   BlocProvider.of<ProductBloc>(context).add(
                          //     AddStockProductEvent(
                          //         product.id, num.parse(controller.text)),
                          //   );
                          //   Navigator.pop(context);
                          // }
                        },
                        child: const Text("Ajouter"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 15,
                          ),
                          primary: Colors.black,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
