import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/models/event.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Evennements"),
      ),
      body: ListView.builder(
          itemCount: eventLists.length,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 140,
          ),
          itemBuilder: (context, index) {
            return EventTile(
              event: eventLists[index],
            );
          }),
    );
  }
}

class EventTile extends StatelessWidget {
  const EventTile({
    required this.event,
    Key? key,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 270,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                event.imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            )),
            ListTile(
              title: Text(
                event.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              subtitle: Text(
                event.place + " " + event.date,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.suit_heart),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
