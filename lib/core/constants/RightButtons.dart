import 'package:flutter/material.dart';

class RightButtons extends StatefulWidget {
  const RightButtons({super.key});

  @override
  State<RightButtons> createState() => _RightButtonsState();
}

class _RightButtonsState extends State<RightButtons> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12,
      bottom: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(Icons.category, 'Category', 0, () {
            setState(() => selectedIndex = 0);
            Navigator.pushNamed(context, '/categorySelector');
          }),

          const SizedBox(height: 16),
          _buildButton(Icons.date_range, 'Date', 1, () {
            setState(() => selectedIndex = 1);
          }),

          const SizedBox(height: 16),
          _buildButton(Icons.directions_car, 'Car', 2, () {
            setState(() => selectedIndex = 2);
          }),

          const SizedBox(height: 16),
          _buildButton(Icons.bookmark_border, 'Save', 3, () {
            setState(() => selectedIndex = 3);
          }),

          const SizedBox(height: 16),
          _buildButton(Icons.share, 'Share', 4, () {
            setState(() => selectedIndex = 4);
          }),

          const SizedBox(height: 16),
          _buildButton(Icons.info_outline, 'Info', 5, () {
            setState(() => selectedIndex = 5);
          }),
        ],
      ),
    );
  }

  Widget _buildButton(
    IconData icon,
    String label,
    int index,
    VoidCallback onPressed,
  ) {
    final bool isSelected = selectedIndex == index;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.blueAccent : Colors.transparent,
          ),
          padding: const EdgeInsets.all(8),
          child: IconButton(
            icon: Icon(icon, size: 28, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
