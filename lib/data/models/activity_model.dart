class Activitymodel {
  final String title;
  final String image;
  final double price;
  final int number;
  final int duration;
  final double rate;

  Activitymodel({
    required this.title,
    required this.image,
    required this.price,
    required this.number,
    required this.duration,
    required this.rate,
  });
}

List<Activitymodel> exmactivities = [
  Activitymodel(
    title: "Egyptian Museum",
    image: "assets/images/museum.png",
    price: 55,
    number: 1,
    duration: 50,
    rate: 1,
  ),
];
