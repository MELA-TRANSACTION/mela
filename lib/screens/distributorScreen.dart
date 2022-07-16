import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/distrib/distributors_bloc.dart';
import 'package:mela/models/distributor.dart';

class DistributorScreen extends StatelessWidget {
  const DistributorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mela"),
        leading: Container(),
        leadingWidth: 5,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.refresh))
        ],
      ),
      body: BlocBuilder<DistributorsBloc, DistributorsState>(
        bloc: BlocProvider.of<DistributorsBloc>(context)
          ..add(LoadDistributorsEvent()),
        builder: (context, state) {
          if (state is DistributorsSuccess) {
            if (state.distributors.isEmpty) {
              return const Center(
                child: Text("Pas de distributeurs"),
              );
            }
            return ListView.builder(
                itemCount: state.distributors.length,
                padding: const EdgeInsets.only(
                    top: 24, left: 12, right: 12, bottom: 80),
                itemBuilder: (context, index) {
                  return DistributorTile(
                    distributor: state.distributors[index],
                  );
                });
          }
          if (state is DistributorsFailure) {
            return const Center(
              child: Text("Error"),
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

class DistributorTile extends StatelessWidget {
  const DistributorTile({
    required this.distributor,
    Key? key,
  }) : super(key: key);

  final Distributor distributor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 0.7),
      child: ListTile(
        title: Text(
          "${distributor.name} ",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text("${distributor.city} / ${distributor.address}"),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.location),
        ),
      ),
    );
  }
}
