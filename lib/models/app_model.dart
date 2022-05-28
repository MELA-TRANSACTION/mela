class AppModel {
  String title;
  String content;
  String img;

  AppModel({required this.title, required this.content, required this.img});
}

List<AppModel> appData = [
  AppModel(
    title: "Partager",
    content:
        "Partageons le bonheur de la biere avec vos proches partout ils peuvents etre.",
    img: "images/celebration_beer.svg",
  ),
  AppModel(
    title: "Recharger",
    img: "images/undraw_beer.svg",
    content:
        "Reserver meme pour demain, votre biere en le rechargeant dans un votre phone!",
  ),
  AppModel(
    title: "Retrait",
    img: "images/undraw_beer.svg",
    content:
        "Deplacez-vous partout avec vos Boissons et faites vos retraits chez nos partenaires, de votre choix",
  )
];
