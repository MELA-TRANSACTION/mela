import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/screens/share/share_screen.dart';

class ShareFinishScreen extends StatefulWidget {
  const ShareFinishScreen({Key? key}) : super(key: key);

  @override
  State<ShareFinishScreen> createState() => _ShareFinishScreenState();
}

class _ShareFinishScreenState extends State<ShareFinishScreen> {
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              title: Text(
                "Cocher tout",
                style: TextStyle(
                  color: Colors.blue[700],
                ),
              ),
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
              subtitle: const Text("2 bouteils"),
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
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ShareScreen(),
            ),
          );
        },
        child: const Text(
          "Je partage 4 Bouteiles",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          primary: Colors.blue[800],
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
        ),
      ),
    );
  }
}
