import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/product.dart';
import 'package:mela/screens/distributorScreen.dart';
import 'package:mela/services/api_service.dart';
import 'package:pinput/pinput.dart';

class FinalisationRecharge extends StatefulWidget {
  const FinalisationRecharge({
    Key? key,
    required this.product,
    required this.receiver,
    required this.quantity,
    required this.typeTrans,
  }) : super(key: key);
  final Product product;
  final int quantity;
  final String receiver;
  final String typeTrans;

  @override
  State<FinalisationRecharge> createState() => _FinalisationRechargeState();
}

class _FinalisationRechargeState extends State<FinalisationRecharge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmation"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "images/fingerprint.svg",
              color: Colors.white,
              height: 56,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Vous pouvez confirmer cette operation ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            buildAuthenticate(context),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Confirmer',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAvailable = await LocalAuthApi.hasBiometrics();
          final biometrics = await LocalAuthApi.getBiometrics();

          final hasFingerprint = biometrics.contains(BiometricType.fingerprint);

          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            BlocProvider.of<TransBloc>(context).add(
              AddShareEvent(
                product: widget.product.id,
                destinateur: widget.receiver,
                quantity: widget.quantity,
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const DistributorScreen()),
            );
          }
        },
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}
