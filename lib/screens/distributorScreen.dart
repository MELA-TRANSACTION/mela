import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DistributorScreen extends StatelessWidget {
  const DistributorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Distributeurs"),
        leading: Container(),
        leadingWidth: 5,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.refresh))
        ],
      ),
      body: ListView.builder(
          itemCount: 7,
          padding:
              const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 80),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.only(top: 0.7),
              child: ListTile(
                title: const Text(
                  "Chez Pili-Pili",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text("Rond point tchukudu"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.location),
                ),
              ),
            );
          }),
    );
  }
}
