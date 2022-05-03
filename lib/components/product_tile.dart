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
                    "${product.quantity.ceil()}",
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
      ),
    );
  }
}
