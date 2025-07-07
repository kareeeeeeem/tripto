import 'package:flutter/material.dart';
import '../../presentation/pagess/RightButtonsPages/CategoryCard.dart';

class RightButtons extends StatefulWidget {
  const RightButtons({super.key});

  @override
  State<RightButtons> createState() => _RightButtonsState();
}

class _ButtonData {
  final IconData icon;
  final String label;

  _ButtonData({required this.icon, required this.label});
}

class _RightButtonsState extends State<RightButtons> {
  int selectedIndex = -1;

  OverlayEntry? _categoryOverlay; // للتحكم في إظهار/إخفاء الكاتيجوري

  final List<_ButtonData> _buttons = [
    _ButtonData(icon: Icons.category, label: 'Category'),
    _ButtonData(icon: Icons.directions_car, label: 'Car'),
    _ButtonData(icon: Icons.bookmark_border, label: 'Save'),
    _ButtonData(icon: Icons.share, label: 'Share'),
    _ButtonData(icon: Icons.info_outline, label: 'Info'
    ),
  ];

  static const double _verticalSpacing = 16.0;

  void _toggleCategoryOverlay(BuildContext context) {
    if (_categoryOverlay != null) {
      _categoryOverlay!.remove();
      _categoryOverlay = null;
      return;
    }

    _categoryOverlay = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 100,
            left: 10,
            child: Material(
              color: Colors.transparent,
              child: CategoryCard(
                onClose: () {
                  _categoryOverlay?.remove();
                  _categoryOverlay = null;
                },
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_categoryOverlay!);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12,
      bottom: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_buttons.length, (index) {
          final buttonData = _buttons[index];
          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0 : _verticalSpacing),
            child: _buildButton(buttonData.icon, buttonData.label, index, () {
              setState(() => selectedIndex = index);

              if (buttonData.label == 'Category') {
                _toggleCategoryOverlay(context);
              }
              // يمكنك إضافة منطق لباقي الأزرار هنا حسب الحاجة
            }),
          );
        }),
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
        const SizedBox(height: 1),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
