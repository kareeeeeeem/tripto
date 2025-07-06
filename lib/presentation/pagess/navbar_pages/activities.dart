import 'package:flutter/material.dart';
import '../../../data/models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final Activitymodel activity;

  const ActivityCard({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 136,
        width: 250,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: double.infinity,
                width: 60,
                child: Image.asset(
                  "assets/images/museum.png",
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 25),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        activity.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Price: \$${activity.price.toStringAsFixed(0)}'),
                      Text('Number: ${activity.number}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  SizedBox(width: 50),


                ],
              ),
            ),
            Column(
              children: [
                Text(' ⭐ ${activity.rate} '),
                Text('For: ${activity.duration} min'),
                const Icon(Icons.directions_car_filled_sharp, size: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Book'),
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
}

class Activities extends StatelessWidget {
  const Activities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Activities",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: exmactivities.length,
        itemBuilder: (context, index) {
          final activity = exmactivities[index];
          return ActivityCard(activity: activity);
        },
      ),
    );
  }
}
