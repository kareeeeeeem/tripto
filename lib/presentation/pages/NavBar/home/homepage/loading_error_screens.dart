import 'package:flutter/material.dart';

Widget buildLoadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(color: Color(0xFF002E70)),
  );
}

Widget buildVideoErrorWidget() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.cloud_off, size: 50, color: Colors.white),
        SizedBox(height: 16),
        Text(
          "Video could not be loaded",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}