// tripto/core/models/CarModel.dart
import 'package:flutter/material.dart';

class CarModel {
  final String name;
  final String imageUrl;
  final String description;
  final double pricePerDay;

  CarModel({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.pricePerDay,
  });
}

// قائمة أمثلة للسيارات (يمكن أن تكون في نفس الملف أو ملف منفصل)
final List<CarModel> carsList = [
  CarModel(
    name: 'Toyota Camry',
    imageUrl: 'assets/images/camry.png', // تأكد من وجود هذه الصورة
    description: 'سيارة سيدان مريحة واقتصادية.',
    pricePerDay: 50.0,
  ),
  CarModel(
    name: 'Mercedes-Benz C-Class',
    imageUrl: 'assets/images/mercedes.png', // تأكد من وجود هذه الصورة
    description: 'سيارة فاخرة بتجربة قيادة ممتعة.',
    pricePerDay: 120.0,
  ),
  CarModel(
    name: 'Hyundai Elantra',
    imageUrl: 'assets/images/elantra.png', // تأكد من وجود هذه الصورة
    description: 'سيارة عملية ومناسبة للميزانية.',
    pricePerDay: 40.0,
  ),
  CarModel(
    name: 'BMW X5',
    imageUrl: 'assets/images/bmw_x5.png', // تأكد من وجود هذه الصورة
    description: 'سيارة دفع رباعي فخمة وعالية الأداء.',
    pricePerDay: 150.0,
  ),
];

// ودجت CarCard (مثال، تأكد من أن لديك هذا الملف)
class CarCard extends StatelessWidget {
  final CarModel car;
  final bool isSelected;
  final VoidCallback onTap;

  const CarCard({
    Key? key,
    required this.car,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: isSelected ? 8 : 2,
        color: isSelected ? Colors.blue.shade100 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side:
              isSelected
                  ? const BorderSide(color: Colors.blue, width: 2)
                  : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  car.imageUrl,
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 60,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, color: Colors.red),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      car.description,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${car.pricePerDay.toStringAsFixed(0)}/day',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
