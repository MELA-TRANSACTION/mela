import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mela/blocs/distrib/distributors_bloc.dart';
import 'package:mela/screens/withdraw/withdraw_finish.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  String distributor = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Au pres de "),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        children: [
          const SizedBox(
            height: 40,
          ),
          IntlPhoneField(
            onChanged: (v) {
              setState(() {
                distributor = v.completeNumber;
              });
            },
            showCountryFlag: false,
            initialCountryCode: "CD",
            dropdownTextStyle: const TextStyle(
              color: Colors.white,
            ),
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              label: Text("Distributeur"),

              // fillColor: Colors.white,
              // filled: true,
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
                  builder: (context) =>
                      WithDrawFinish(distributor: distributor),
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
