import 'package:flutter/material.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import '../../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/ِAuth/AuthState.dart';
import 'package:tripto/bloc/ِAuth/AuthEvent.dart';
import 'package:tripto/bloc/ِAuth/AuthBloc.dart';
import 'package:tripto/core/constants/CustomButton.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import '../../../l10n/app_localizations.dart';

class ActivityCard extends StatelessWidget {
  final GetActivityModel activity;
  final bool isSelected;
  final VoidCallback onTap;

  const ActivityCard({
    required this.activity,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

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
                            activity.activitynameen ?? '',
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
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [Text(' ⭐ ${activity.rate ?? 0} ')],
                    // ),
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
  const ActivitiesListDialog({Key? key}) : super(key: key);

  @override
  State<ActivitiesListDialog> createState() => _ActivitiesListDialogState();
}

class _ActivitiesListDialogState extends State<ActivitiesListDialog> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    // اطلب الداتا لما يفتح الدايالوج
    context.read<AuthBloc>().add(FetchAcvtivites());
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
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
                    return const Center(child: CircularProgressIndicator());
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
                bottom: 8.0,
                left: 20.0,
                right: 20.0,
                top: 8.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.055,
                child: CustomButton(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
