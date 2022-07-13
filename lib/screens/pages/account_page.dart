import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/components/trans_tile.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/trans_mela.dart';
import 'package:mela/screens/distributorScreen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isActive) => [
        SliverAppBar(
          expandedHeight: 140,
          flexibleSpace: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          "images/logo_mela_svg.svg",
                          height: 54,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.qrcode,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.person,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: const [
                              Text("Balance"),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "0 ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "CDF",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                              CupertinoIcons.arrow_down_right_arrow_up_left),
                          label: Text("Echanger"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      body: Stack(
        children: [
          Container(
            child: BlocBuilder<TransBloc, TransState>(
              builder: (context, state) {
                if (state is TransStateSuccess) {
                  return ListView.builder(
                      padding: const EdgeInsets.only(
                          left: 1, right: 1, top: 1, bottom: 140),
                      itemCount: state.trans.length,
                      itemBuilder: (context, index) {
                        Trans trans = state.trans[index];
                        return TransTile(trans: trans);
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {},
                    label: const Text(
                      "Partager ou payer",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    icon: const Icon(
                      CupertinoIcons.qrcode_viewfinder,
                      size: 48,
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      height: 78,
                      width: 78,
                      child: const Center(
                          child: Icon(
                        CupertinoIcons.location_solid,
                        size: 32,
                        color: Colors.orange,
                      )))
                ],
              ))
        ],
      ),
    );
  }
}

class LoginAction extends StatelessWidget {
  const LoginAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "images/logo_mela_svg.svg",
                        height: 56,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.qrcode,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.person,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          Text("Balance"),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "0 ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "CDF",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                            CupertinoIcons.arrow_down_right_arrow_up_left),
                        label: Text("Echanger"),
                      )
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.qrcode_viewfinder,
                      size: 62,
                    ),
                    label: Text("Partager ou regler"),
                    style: TextButton.styleFrom(primary: Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //body: ,
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DistributorScreen(),
            ),
          );
        },
        tooltip: "Distributors",
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.amber[600],
        child: const Icon(
          CupertinoIcons.location,
          color: Colors.black,
        ),
      ),
    );
  }
}
