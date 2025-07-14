import 'package:flutter/material.dart';
import 'package:tripto/core/models/activity_model.dart';
import 'package:tripto/presentation/app/app.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routes/app_routes.dart';

class ActivityCard extends StatelessWidget {
  final Activitymodel activity;

  const ActivityCard({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.activityDetailsPageRoute,
            arguments: activity,
          );
        },

        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            height: 136,
            width: 130,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: double.infinity,
                      width: 100,
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Text('Price: \$${activity.price.toStringAsFixed(0)} '),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Price: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              TextSpan(
                                text: '\$',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black, // لون علامة الدولار
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${activity.price.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // لون السعر
                                ),
                              ),
                            ],
                          ),
                        ),

                        // const SizedBox(height: 4),
                        // Text('Number: ${activity.number}'),
                      ],
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(' ⭐ ${activity.rate} '),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0001,
                          ),
                          Text('For: ${activity.duration} min'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.001,
                          ),

                          const Icon(
                            Icons.directions_car_filled_sharp,
                            size: 20,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(110, 37),
                          backgroundColor: btn_background_color_gradiant,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.paymentOption);
                        },

                        child: const Text(
                          'Book',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // هنا التعديل
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const App(),
              ), // العودة إلى App
              (Route<dynamic> route) => false, // إزالة جميع المسارات السابقة
            );
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.12, // تقريبًا 12% من الشاشة
        ),
        itemCount: exmactivities.length,
        itemBuilder: (context, index) {
          final activity = exmactivities[index];
          return ActivityCard(activity: activity);
        },
      ),
    );
  }
}
