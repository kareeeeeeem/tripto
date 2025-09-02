import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthState.dart';
import 'package:tripto/core/constants/CustomButton.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/SlideBar/activity/ActivitiesCard.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';

class ActivitiesListDialog extends StatefulWidget {
  final int? initialSelectedActivityId; // ✅ هنا نقبل المعرف فقط
  final GlobalKey<PersonCounterWithPriceState>? personCounterKey; // ✅ أضف هذا

  const ActivitiesListDialog({
    Key? key,
    this.initialSelectedActivityId,
    this.personCounterKey,
  }) : super(key: key);

  @override
  State<ActivitiesListDialog> createState() => _ActivitiesListDialogState();
}

class _ActivitiesListDialogState extends State<ActivitiesListDialog> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(FetchAcvtivites());

    // ✅ نستخدم WidgetsBinding للتأكد من أن البيانات موجودة قبل البحث
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AuthBloc>().state;
      if (state is GetAllActivitiesSuccess) {
        final activities = state.activities;
        final index = activities.indexWhere(
          (a) => a.id == widget.initialSelectedActivityId,
        );
        if (index != -1) {
          setState(() {
            selectedIndex = index;
          });
        }
      }
    });
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
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: Size(screenWidth * 0.80, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedIndex = null;
                      });
                      // ✅ تصفير السعر عند Cancel
                      if (widget.personCounterKey != null) {
                        widget.personCounterKey!.currentState
                            ?.setSelectedActivityPrice(0);
                      }
                      Navigator.pop(context, null);
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
