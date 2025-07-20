import 'package:flutter/material.dart';

class Countrywithcity extends StatelessWidget {
  final String countryName;
  final String cityName;

  const Countrywithcity({
    super.key,
    required this.countryName,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment:
          Directionality.of(context) == TextDirection.rtl
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: [
        Text(
          '$cityName , $countryName',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            shadows: [
              // يجب أن تكون هذه الخاصية موجودة وتحتوي على قائمة من الظلال
              Shadow(
                blurRadius: 5.0,
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
