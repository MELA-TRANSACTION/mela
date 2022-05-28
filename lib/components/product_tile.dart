import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/models/product.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    required this.product,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        //color: Color(0xff0c2359),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: const Color(0xff0e2763),
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "${product.quantity} ",
                    style: TextStyle(color: Colors.amber[700], fontSize: 24),
                  ),
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
            buildAction(
              onTap: () {
                onTap!();
              },
              label: "withdraw",
              icon: CupertinoIcons.up_arrow,
            ),
            buildAction(
              onTap: () => onTap!(),
              label: "share",
              icon: Icons.share_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAction(
      {required VoidCallback onTap,
      required String label,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        color: label == "share" ? const Color(0xff21CE99) : Colors.white,
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            Text("$label ")
          ],
        ),
      ),
    );
  }
}
