import 'package:flutter/material.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthState.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import '../../../l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/core/constants/CustomButton.dart';

class ActivityCard extends StatelessWidget {
  final GetActivityModel activity;
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
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border:
                    isSelected
                        ? Border.all(color: Colors.blueAccent, width: 3)
                        : null,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Card(
                color: const Color.fromARGB(183, 255, 255, 255),
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
                          child: SizedBox(
                            height: double.infinity,
                            width: 100,
                            child:
                                (activity.images.isNotEmpty &&
                                        activity.images[0].isNotEmpty)
                                    ? Image.network(
                                      activity.images[0].replaceFirst(
                                        "/storage/",
                                        "/storage/app/public/",
                                      ),
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Image.asset(
                                          "assets/images/Logo.png",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                    : Image.asset(
                                      "assets/images/Logo.png",
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
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? activity.activitynamear
                                    : activity.activitynameen,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${AppLocalizations.of(context)!.price} :',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' \$',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${activity.price}",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Icon(
                                activity.transportation == true
                                    ? Icons.directions_car_filled_sharp
                                    : Icons.directions_walk_sharp,
                                color: Colors.grey[800],
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ✅ أيقونة الصح في أعلى يمين الكارد
            if (isSelected)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blueAccent,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ActivitiesListDialog extends StatefulWidget {
  final GetActivityModel? initiallySelectedActivity; // ✅ جديد

  const ActivitiesListDialog({super.key, this.initiallySelectedActivity});

  @override
  State<ActivitiesListDialog> createState() => _ActivitiesListDialogState();
}

class _ActivitiesListDialogState extends State<ActivitiesListDialog> {
  int? selectedIndex;
  GetActivityModel? selectedActivity; // ✅ نخزن الاختيار
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(FetchAcvtivites());

    if (widget.initiallySelectedActivity != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<AuthBloc>().state;
        if (state is GetAllActivitiesSuccess) {
          final index = state.activities.indexWhere(
            (a) => a.id == widget.initiallySelectedActivity!.id,
          );
          if (index != -1) {
            setState(() {
              selectedIndex = index;
              selectedActivity = state.activities[index];
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 600,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.activities,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // هنا نعرض الـ list عبر BlocBuilder
            Expanded(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF002E70),
                      ),
                    );
                  } else if (state is GetAllActivitiesSuccess) {
                    final activities = state.activities;
                    if (activities.isEmpty) {
                      return Center(child: Text("empty"));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(6),
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        return ActivityCard(
                          activity: activities[index],
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              selectedActivity =
                                  activities[index]; // ✅ نخزن الاختيار
                            });
                          },
                        );
                      },
                    );
                  } else if (state is AuthFailure) {
                    return Center(child: Text(state.error));
                  }
                  return const SizedBox();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    text: AppLocalizations.of(context)!.finish,
                    onPressed: () {
                      final currentState = context.read<AuthBloc>().state;
                      if (selectedIndex != null &&
                          currentState is GetAllActivitiesSuccess) {
                        final selectedActivity =
                            currentState.activities[selectedIndex!];
                        Navigator.pop(context, selectedActivity);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(
                                context,
                              )!.pleaseselectanactivityfirsttoFinish,
                            ),
                          ),
                        );
                      }
                    },
                    width: screenWidth * 0.80,
                    height: 40,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue, // 🔵 أزرق فاتح
                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: Size(screenWidth * 0.80, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedIndex = null; // ✅ الغاء الاختيار
                        selectedActivity = null; // ✅ الغاء الاختيار
                      });
                      Navigator.pop(context, null); // ✅ Cancel Activity
                    },
                    child: Text(
                      AppLocalizations.of(context)!.cancelActivity,

                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
