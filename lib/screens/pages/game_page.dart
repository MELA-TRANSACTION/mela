import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: EmptyGame(),
    );
  }
}

class EmptyGame extends StatelessWidget {
  const EmptyGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 6,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              Text("Info"),
              Icon(
                CupertinoIcons.game_controller,
                size: 56,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Pas des jeux organisés",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
