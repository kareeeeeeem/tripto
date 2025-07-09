// lib/data/models/CarModel.dart
import 'package:flutter/material.dart';

class Carmodel {
  final String image;
  final String title;
  final int colorValue;
  final int person;
  final int? year;

  const Carmodel({
    required this.image,
    required this.title,
    required this.colorValue,
    required this.person,
    this.year,
  });
}

final List<Carmodel> carsList = [
  const Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Toyota Corolla',
    colorValue: 0xFF2196F3,
    person: 4,
    year: 2020,
  ),
  const Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Hyundai Tucson',
    colorValue: 0xFFD32F2F,
    person: 6,
    year: 2022,
  ),
  const Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Mercedes C180',
    colorValue: 0xFF424242,
    person: 4,
    year: 2021,
  ),
  const Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'GMC',
    colorValue: 0xFF9E9E9E,
    person: 6,
    year: 2019,
  ),
];
