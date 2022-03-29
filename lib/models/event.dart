class Event {
  String title;
  String place;
  String imageUrl;
  String date;

  Event({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.place,
  });
}

List<Event> eventLists = [
  Event(
      imageUrl: "images/1.png",
      title: "2 contre 1",
      date: "A partir de 1h",
      place: "Muzipela"),
  Event(
      imageUrl: "images/2.png",
      title: "2 contre 1",
      date: "A partir de 15h",
      place: "Muzipela"),
  Event(
      imageUrl: "images/3.jpg",
      title: "2 contre 1",
      date: "A partir de 15h",
      place: "Muzipela"),
  Event(
      imageUrl: "images/2.png",
      title: "2 contre 1",
      date: "A partir de 15h",
      place: "Muzipela"),
  Event(
      imageUrl: "images/3.jpg",
      title: "2 contre 1",
      date: "A partir de 15h",
      place: "Muzipela"),
  Event(
      imageUrl: "images/2.png",
      title: "2 contre 1",
      date: "A partir de 15h",
      place: "Muzipela"),
  Event(
      imageUrl: "images/3.jpg",
      title: "2 contre 1",
      date: "A partir de 15h",
      place: "Muzipela"),
];
