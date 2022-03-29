import 'package:flutter/material.dart';
import 'package:mela/screens/withdraw/withdraw_finish.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Au pres de "),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        children: [
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: const Text("Distributeur"),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Text(
                  "No",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Aucun distributeur",
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(
            height: 72,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WithDrawFinish(),
                ),
              );
            },
            child: const Text("Continuer"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              primary: Colors.blue[900],
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
