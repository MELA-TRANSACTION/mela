import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:mela/components/basket_item.dart';
import 'package:mela/components/quantity_input.dart';
import 'package:mela/models/product.dart';
import 'package:mela/screens/recharge/finalisation_recharge.dart';

class RechargeBasketScreen extends StatefulWidget {
  const RechargeBasketScreen({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  State<RechargeBasketScreen> createState() => _RechargeBasketScreenState();
}

class _RechargeBasketScreenState extends State<RechargeBasketScreen> {
  String destinateur = '';
  int quantity = 0;

  late Product product;

  @override
  void initState() {
    product = widget.product;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recharger Client"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            CupertinoIcons.chevron_left,
            color: Colors.blue[50],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          //vertical: 24,
        ),
        children: [
          const SizedBox(
            height: 16,
          ),
          BasketItem(
            product: product,
            onTap: () {},
          ),
          const SizedBox(
            height: 24,
          ),
          IntlPhoneField(
            onChanged: (v) => {
              setState(
                () {
                  destinateur = v.completeNumber;
                },
              )
            },
            //validator: (value) => value!.completeNumber.length < 10 ? "" : "",
            initialCountryCode: "CD",
            showCountryFlag: false,
            style: const TextStyle(
              color: Colors.white,
            ),
            dropdownTextStyle: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: const Text("Destinateur"),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Icon(
                  Icons.phone_iphone_rounded,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          QuantityInput(
            onChanged: (value) {
              setState(() {
                quantity = int.parse(value!);
              });
            },
            placeHolder: "Quantité",
          ),
          const SizedBox(
            height: 56,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FinalisationRecharge(
                    product: product,
                    receiver: destinateur,
                    quantity: quantity,
                    typeTrans: "Recharger-client",
                  ),
                ),
              );
            },
            child: const Text("Recharger"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 0,
              ),
              primary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProdBasketTile extends StatelessWidget {
  const ProdBasketTile({
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "images/wine.svg",
              height: 64,
              width: 44,
              color: Colors.white,
            ),
            Text(
              product.name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "${product.quantity}",
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 24,
              ),
            ),
          ],
        ),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
