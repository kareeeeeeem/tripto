import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/car/car_bloc.dart';
import 'package:tripto/bloc&repo/car/car_state.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/SlideBar/car/CarDetials.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';

class CarSelectionPage extends StatefulWidget {
  final int? selectedCarId;
  final GlobalKey<PersonCounterWithPriceState>? personCounterKey; // ✅

  const CarSelectionPage({
    super.key,
    this.selectedCarId,
    this.personCounterKey,
  });

  @override
  State<CarSelectionPage> createState() => _CarSelectionPageState();
}

class _CarSelectionPageState extends State<CarSelectionPage> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<CarBloc>().state;
      if (state is CarLoaded && widget.selectedCarId != null) {
        final index = state.cars.indexWhere(
          (c) => c.id == widget.selectedCarId,
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
                    return const SizedBox(
                      height: 80,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Color(0xFF002E70),
                        ),
                      ),
                    );
                  } else if (state is CarLoaded) {
                    final cars = state.cars;
                    if (selectedIndex == null && widget.selectedCarId != null) {
                      final index = cars.indexWhere(
                        (c) => c.id == widget.selectedCarId,
                      );
                      if (index != -1) {
                        selectedIndex = index;
                      }
                    }
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
                      // ✅ زر الاستمرار
                      ElevatedButton(
                        onPressed: (selectedIndex != null && cars.isNotEmpty)
                            ? () {
                                final selectedCar = cars[selectedIndex!];
                                Navigator.of(context).pop(selectedCar);
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
                        child: Text(
                          AppLocalizations.of(context)!.continueButton,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // ✅ زر الإلغاء
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
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
                          setState(() {
                            selectedIndex = null;
                          });
                          // ✅ تصفير السعر الإضافي للعربية
                          widget.personCounterKey?.currentState
                              ?.setSelectedCarPrice(0);

                          Navigator.of(context).pop(null);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.cancelCar,
                          style: const TextStyle(fontSize: 18),
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
