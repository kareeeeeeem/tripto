import 'package:flutter/material.dart';
import 'package:tripto/core/constants/CustomButton.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import 'package:tripto/core/routes/app_routes.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pagess/NavBar/home_page.dart';

class ActivityCard extends StatelessWidget {
  final Activitymodel activity;
  final bool isSelected;
  final VoidCallback onTap;

  const ActivityCard({
    required this.activity,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border:
                isSelected
                    ? Border.all(color: Colors.blueAccent, width: 3)
                    : null,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              height: 136,
              width: double.infinity,
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
                        children: [
                          Text(
                            activity.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text(' ⭐ ${activity.rate} ')],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActivitiesListDialog extends StatefulWidget {
  const ActivitiesListDialog({super.key});

  @override
  State<ActivitiesListDialog> createState() => _ActivitiesListDialogState();
}

class _ActivitiesListDialogState extends State<ActivitiesListDialog> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 600,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Activities',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(6),
                itemCount: exmactivities.length,
                itemBuilder: (context, index) {
                  return ActivityCard(
                    activity: exmactivities[index],
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
                left: 20.0,
                right: 20.0,
                top: 8.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: CustomButton(
                  text: "Finish",
                  onPressed: () {
                    if (selectedIndex != null) {
                      final selectedActivity = exmactivities[selectedIndex!];

                      /// ✅ أقفل الـ Dialog وارجع النشاط المحدد (اختياريًا)
                      Navigator.pop(context, selectedActivity);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select an activity first'),
                        ),
                      );
                    }
                  },

                  width: screenWidth * 0.80,
                  height: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
