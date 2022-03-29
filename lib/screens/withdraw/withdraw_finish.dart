import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WithDrawFinish extends StatefulWidget {
  const WithDrawFinish({Key? key}) : super(key: key);

  @override
  State<WithDrawFinish> createState() => _WithDrawFinishState();
}

class _WithDrawFinishState extends State<WithDrawFinish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: CheckboxListTile(
              onChanged: (v) {},
              value: true,
              title: const Text("Cocher tout"),
            ),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: 72,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1,
            margin: const EdgeInsets.only(top: 0.8),
            child: ListTile(
              leading: SvgPicture.asset(
                "images/beer1.svg",
                height: 44,
                width: 40,
              ),
              title: const Text("Doppel"),
              subtitle: Text("2 bouteils"),
              trailing: Checkbox(
                onChanged: (value) {},
                value: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        child: const Text(
          "Je retire 4 B",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          primary: Colors.blue[800],
          padding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
        ),
      ),
    );
  }
}
