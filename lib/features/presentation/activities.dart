import 'package:flutter/material.dart';
import '../../data/models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final Activitymodel activity;

  const ActivityCard({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset("assets/images/museum.png",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text('Price: \$${activity.price.toStringAsFixed(0)}'),
                Text('Number: ${activity.number}'),
                Text('Rating: ${activity.rate} '),
                Text('Duration: ${activity.duration} min'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.directions_bus, size: 20),
                    ElevatedButton(onPressed: () {}, child: const Text('Book')),
                  ],
                ),
              ],
            ),
          ),
        ],
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

