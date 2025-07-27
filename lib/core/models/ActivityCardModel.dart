import 'package:flutter/foundation.dart';

class ActivityCardmodel {
  final String title;
  final String image;
  final double price;
  final int number;
  final int duration;
  final double rate;

  ActivityCardmodel({
    required this.title,
    required this.image,
    required this.price,
    required this.number,
    required this.duration,
    required this.rate,
  });

  // factory ActivityCardmodel.fromjson(Map<String, dynamic> json){
  //   return ActivityCardmodel(
  //     title: json['title'],
  //     image: json['image'],
  //     price: json['price'],
  //     number: json['number'],
  //     duration: json['duration'],
  //     rate: json['rate'],
  //   );
  // }
}


List<ActivityCardmodel> exmactivities = [
  ActivityCardmodel(
    title: "Egyptian Museum",
    image: "assets/images/museum.png",
    price: 55,
    number: 1,
    duration: 50,
    rate: 1,
  ),
  ActivityCardmodel(
    title: "Egyptian Museum",
    image: "assets/images/museum.png",
    price: 55,
    number: 1,
    duration: 50,
    rate: 1,
  ),
  ActivityCardmodel(
    title: "Egyptian Museum",
    image: "assets/images/museum.png",
    price: 55,
    number: 1,
    duration: 50,
    rate: 1,
  ),
  ActivityCardmodel(
    title: "Egyptian Museum",
    image: "assets/images/museum.png",
    price: 55,
    number: 1,
    duration: 50,
    rate: 1,
  ),
  ActivityCardmodel(
    title: "Egyptian Museum",
    image: "assets/images/museum.png",
    price: 55,
    number: 1,
    duration: 50,
    rate: 1,
  ),
  ActivityCardmodel(
    title: "Egyptian Museum",
    image: "assets/images/museum.png",
    price: 55,
    number: 1,
    duration: 50,
    rate: 1,
  ),
  ActivityCardmodel(
    title: "Egyptian Museum",
    image: "assets/images/museum.png",
    price: 55,
    number: 1,
    duration: 50,
    rate: 1,
  ),
];
