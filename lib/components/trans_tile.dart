import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/utils.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mela/models/trans_mela.dart';

class TransTile extends StatelessWidget {
  const TransTile({
    required this.trans,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Trans trans;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          //color: Color(0xff0c2359),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          elevation: 0.5,
          margin: const EdgeInsets.only(top: 1),
          child: ListTile(
            leading: trans.typeTrans == "SEND"
                ? const Icon(CupertinoIcons.arrow_turn_right_down)
                : const Icon(CupertinoIcons.arrow_up),
            title: Text(
              messageFormat(trans.uid, trans.sender, trans.receiver),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
                "${Utils.getDay(DateTime.fromMillisecondsSinceEpoch(trans.createdAt))} à ${Utils.formatDate(DateTime.fromMillisecondsSinceEpoch(trans.createdAt))}"),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${trans.amount.amount}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.orange[700],
                    fontSize: 18,
                  ),
                ),
                Text("${trans.amount.currency} "),
              ],
            ),
          )),
    );
  }

  String timeAgo(int t) {
    // Add french messages
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    var fifteenAgo = DateTime.fromMillisecondsSinceEpoch((t / 1000).ceil());

    return timeago.format(fifteenAgo, locale: 'fr');
  }

  String messageFormat(String uid, var sender, var receiver) {
    if (uid == sender.uid) {
      return "Envoie à ${receiver.name}";
    } else {
      return "Recu de ${receiver.name}";
    }
  }
}
