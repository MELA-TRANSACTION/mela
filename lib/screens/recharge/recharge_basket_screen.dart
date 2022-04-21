import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/screens/recharge/list_product_screen.dart';

class RechargeBasketScreen extends StatefulWidget {
  const RechargeBasketScreen({Key? key}) : super(key: key);

  @override
  State<RechargeBasketScreen> createState() => _RechargeBasketScreenState();
}

class _RechargeBasketScreenState extends State<RechargeBasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recharge client"),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xff0e2763),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              child: Column(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    onPressed: () async {
                      var result = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const ListProductScreen()));

                      // setState(() {
                      //   product.category = result as Category;
                      // });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                CupertinoIcons.square_on_square,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              // Text(product.category?.name ?? "Choisir categorie"),
                              Text("Choisir categorie")
                            ],
                          ),
                          const Icon(
                            CupertinoIcons.arrowtriangle_down,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    //enabled: false,
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: const Center(
                              child: Text(
                            "3",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          )),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(CupertinoIcons.minus),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
            const Text(
              "Votre pannier contient 3 produits.",
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          height: 60,
                          width: 120,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 120,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 120,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 120,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Continuer"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
