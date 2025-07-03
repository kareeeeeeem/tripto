import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  final List<IconData> _icons = const [
    Icons.home,
    Icons.extension,
    Icons.person_2_outlined,
    Icons.favorite_border,
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_icons.length, (index) {
                return GestureDetector(
                  onTap: () => onTabSelected(index),
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
      ),
    );
  }
}
