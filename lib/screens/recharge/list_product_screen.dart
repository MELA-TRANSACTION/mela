import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/product.dart';
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
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 7 / 9,
                ),
                itemCount: state.trans.length,
                padding: const EdgeInsets.only(
                  right: 8,
                  left: 8,
                  top: 16,
                  bottom: 120,
                ),
                itemBuilder: (context, index) {
                  Product product = state.trans[index].product;
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

// class ProductTile extends StatefulWidget {
//   const ProductTile({
//     required this.product,
//     Key? key,
//   }) : super(key: key);
//
//   final Product product;
//
//   @override
//   State<ProductTile> createState() => _ProductTileState();
// }
//
// class _ProductTileState extends State<ProductTile> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showBott(context, widget.product);
//       },
//       child: Card(
//         //color: Color(0xff0c2359),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         color: const Color(0xff0e2763),
//         margin: const EdgeInsets.only(top: 1),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           child: Row(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "${widget.product.quantity.ceil()}",
//                     style: TextStyle(color: Colors.amber[700], fontSize: 32),
//                   ),
//                   SizedBox(
//                     width: 24,
//                     child: SvgPicture.asset(
//                       "images/wine.svg",
//                       height: 24,
//                       width: 22,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 width: 24,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${widget.product.name} ",
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               const Icon(
//                 CupertinoIcons.chevron_right,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
