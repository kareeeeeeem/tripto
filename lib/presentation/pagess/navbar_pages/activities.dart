import 'package:flutter/material.dart';
import '../../../data/models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final Activitymodel activity;

  const ActivityCard({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: 136,
          width: 130,
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
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    const SizedBox(height: 4),
                    Text('Number: ${activity.number}'),
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(' ⭐ ${activity.rate} '),
                  Text('For: ${activity.duration} min'),
                  const Icon(Icons.directions_car_filled_sharp, size: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2196F3)),
                    onPressed: () {},
                    child: const Text('Book' , style: TextStyle(color: Colors.white),),
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
