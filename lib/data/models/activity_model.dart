class activitymodel {
  final String title;
  final String image;
  final double price;
  final int Number;
  final int duration;
  final double rate;

  activitymodel({
    required this.title,
    required this.image,
    required this.price,
    required this.Number,
    required this.duration,
    required this.rate,
  });
}
List<activitymodel> exmactivities = [
  activitymodel (
  title : "Egyptian Museum",
    image : "assets/images/museum.png" ,
    price : 55,
    Number :1,
    duration : 50,
    rate: 1,
  ),
];
