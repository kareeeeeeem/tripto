import 'package:flutter/material.dart';
import 'package:tripto/core/models/Hotelsـmodel.dart';

class HotelAdelPage extends StatelessWidget {
  final HotelModel hotel;

  const HotelAdelPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hotel.nameEn ?? "Hotel")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صور الفندق
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: hotel.images.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      hotel.images[index],
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            Text(
              hotel.descriptionEn ?? "No description",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            Text("Rate: ⭐ ${hotel.rate ?? 0}"),
            const SizedBox(height: 6),

            Text(
              "Price per night: \$${hotel.pricePerNight.toStringAsFixed(2)}",
            ),
            const SizedBox(height: 6),

            Text("Location: ${hotel.placeEn ?? 'Unknown'}"),
            const SizedBox(height: 6),

            Text("Room Type: ${hotel.roomType ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }
}
