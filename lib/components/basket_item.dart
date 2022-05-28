import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/models/product.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({
    required this.product,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "images/wine.svg",
              height: 64,
              width: 44,
              color: Colors.amber,
            ),
            Text(
              product.quantity.toString(),
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 24,
              ),
            ),
            Text(
              "${product.name} ",
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 24,
              ),
            ),
          ],
        ),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
