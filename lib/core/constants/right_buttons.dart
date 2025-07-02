import 'package:flutter/material.dart';

class ConstRightButtons extends StatelessWidget {
  const ConstRightButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12,
      bottom: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(Icons.favorite_border, 'Like', () {
            // Like or Save logic
          }),
          const SizedBox(height: 16),

          _buildButton(Icons.date_range, 'Date', () {
            // Show date logic
          }),
          const SizedBox(height: 16),

          _buildButton(Icons.directions_car, 'Car', () {
            // Show car info
          }),
          const SizedBox(height: 16),

          _buildButton(Icons.bookmark_border, 'Save', () {
            // Save video
          }),
          const SizedBox(height: 16),

          _buildButton(Icons.share, 'Share', () {
            // Share logic
          }),
          const SizedBox(height: 16),

          _buildButton(Icons.info_outline, 'Info', () {
            // Show more info
          }),
        ],
      ),
    );
  }
Widget _buildButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
           icon, size: 30,
           color: Colors.white),

          onPressed: onPressed,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}