import 'package:flutter/material.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryDiamond.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryPlatinum.dart';

class CategoryCard extends StatelessWidget {
  final VoidCallback? onClose;

  const CategoryCard({super.key, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onClose != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onClose,
              color: Colors.black,
              iconSize: 20,
              padding: const EdgeInsets.only(right: 4),
            ),
          const GoldCategory(),
          const SizedBox(width: 4),
          const DiamondCategory(),
          const SizedBox(width: 4),
          const PlatinumCategory(),
        ],
      ),
    );
  }
}
