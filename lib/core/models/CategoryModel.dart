import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final Color color;
  final IconData icon;

  CategoryModel({required this.title, required this.color, required this.icon});
}

final List<CategoryModel> categories = [
  CategoryModel(title: 'Gold', color: Colors.amber, icon: Icons.grade),
  CategoryModel(
    title: 'Diamond',
    color: Colors.lightBlueAccent,
    icon: Icons.diamond,
  ),
  CategoryModel(title: 'Platinum', color: Colors.grey, icon: Icons.stars),
];
