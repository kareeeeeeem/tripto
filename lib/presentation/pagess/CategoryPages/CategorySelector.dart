import 'package:flutter/material.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryDiamond.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryPlatinum.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Select Category'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [GoldCategory(), DiamondCategory(), PlatinumCategory()],
        ),
      ),
    );
  }
}
