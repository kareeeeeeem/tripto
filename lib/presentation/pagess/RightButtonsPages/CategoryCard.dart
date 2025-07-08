import 'package:flutter/material.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryDiamond.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryPlatinum.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-30, 0), // حركه شمال 50 بكسل
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(6.0),
          child: SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(child: GoldCategory()),
                SizedBox(width: 8),
                Expanded(child: DiamondCategory()),
                SizedBox(width: 8),
                Expanded(child: PlatinumCategory()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
