import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<IconData> _icons = const [
    Icons.home,
    Icons.extension,
    Icons.person_2_outlined,
    Icons.favorite_border,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 32, right: 32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: Colors.black.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              return GestureDetector(
                onTap: () => onTap(index),
                child: Icon(
                  _icons[index],
                  color: currentIndex == index ? Colors.white : Colors.grey,
                  size: 28,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
