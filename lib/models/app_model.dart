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
        "Faites-vous plaisir en envoyant gratuitement la boisson a vos proches partout ils peuvents etre.",
    img: "images/celebration_beer.svg",
  ),
  AppModel(
    title: "Recharger",
    img: "images/undraw_beer.svg",
    content:
        "Adapter votre consommation des boissons selon votre grain et agenda en faisant vos boissons en virtuels",
  ),
  AppModel(
    title: "Retrait",
    img: "images/undraw_beer.svg",
    content:
        "Deplacez-vous partout avec vos Boissons et faites vos retraits chez nos partenaires, de votre choix",
  )
];
