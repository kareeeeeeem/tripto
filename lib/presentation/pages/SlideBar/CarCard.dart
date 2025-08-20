import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_state.dart';
import 'package:tripto/presentation/pages/widget/CarDetials.dart';
import 'package:tripto/presentation/pages/SlideBar/ActivitiesCard.dart';

class CarSelectionPage extends StatefulWidget {
  final List<VoidCallback> nextSteps;
  final bool hasActivity;

  const CarSelectionPage({
    Key? key,
    this.nextSteps = const [],
    required this.hasActivity,
  }) : super(key: key);

  @override
  State<CarSelectionPage> createState() => _CarSelectionPageState();
}

class _CarSelectionPageState extends State<CarSelectionPage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 85;
    const int maxVisibleItems = 4;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: BlocBuilder<CarBloc, CarState>(
                builder: (context, state) {
                  if (state is CarLoading) {
                    return SizedBox(
                      height: 80,
                      child: const Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      ),
                    );
                  } else if (state is CarLoaded) {
                    final cars = state.cars;
                    final double maxHeight =
                        (cars.length > maxVisibleItems)
                            ? itemHeight * maxVisibleItems
                            : itemHeight * cars.length;

                    return SizedBox(
                      height: maxHeight,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        itemCount: cars.length,
                        itemBuilder: (context, index) {
                          final car = cars[index];
                          final isSelected = selectedIndex == index;

                          return CarCard(
                            car: car,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          );
                        },
                      ),
                    );
                  } else if (state is CarError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<CarBloc, CarState>(
                builder: (context, state) {
                  final cars = (state is CarLoaded) ? state.cars : [];

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed:
                            (selectedIndex != null && cars.isNotEmpty)
                                ? () {
                                  final selectedCar = cars[selectedIndex!];
                                  Navigator.of(context).pop(selectedCar.price);

                                  if (widget.hasActivity) {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) =>
                                              const ActivitiesListDialog(),
                                    );
                                  }

                                  Future.delayed(
                                    const Duration(milliseconds: 100),
                                    () {
                                      if (widget.nextSteps.isNotEmpty) {
                                        widget.nextSteps.first();
                                      }
                                    },
                                  );
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF002E70),
                          foregroundColor: Colors.white,
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.7,
                            45,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue, // 🔵 أزرق فاتح
                          foregroundColor: Colors.white,
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.7,
                            45,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pop(null); // بيرجع null عشان نمسح السعر
                        },
                        child: const Text(
                          'Cancel Car',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
