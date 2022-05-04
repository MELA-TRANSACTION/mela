import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/trans.dart';
import 'package:mela/screens/dashbord_distributor.dart';

class TransPage extends StatelessWidget {
  const TransPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trans"),
      ),
      body: BlocBuilder<TransBloc, TransState>(
        bloc: BlocProvider.of<TransBloc>(context)..add(LoadTransEvent()),
        builder: (context, state) {
          if (state is TransStateSuccess) {
            if (state.trans.isEmpty) {
              return const Center(
                child: Text("aucun trans"),
              );
            }
            return ListView.builder(
                itemCount: state.trans.length,
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 120,
                  right: 16,
                  left: 16,
                ),
                itemBuilder: (context, int index) {
                  Trans trans = state.trans[index];
                  return TransTile(trans: trans);
                });
          }
          if (state is TransStateFailure) {
            return const Center(
              child: Text("une erreur"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
