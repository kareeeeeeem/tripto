import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_event.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_model.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_state.dart';
import 'package:tripto/core/constants/SelectRightButton.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/presentation/pages/SlideBar/ActivitiesCard.dart';
import 'package:tripto/presentation/pages/SlideBar/CarCard.dart';
import 'package:tripto/presentation/pages/SlideBar/CategoryCard.dart';
import 'package:tripto/presentation/pages/SlideBar/DateCard.dart';
import 'package:tripto/presentation/pages/SlideBar/InfoCard.dart';
import 'package:tripto/presentation/pages/SlideBar/HotelsCard.dart';
import 'package:tripto/l10n/app_localizations.dart';

enum CategoryType { none, gold, diamond, platinum }

Color _getColorForCategory(int categoryValue) {
  switch (categoryValue) {
    case 0:
      return const Color(0xFFF1B31C); // Gold
    case 1:
      return const Color(0xFF70D0E0); // Diamond
    case 2:
      return const Color(0xFF6A6969); // Platinum
    default:
      return Colors.white;
  }
}

class _ButtonData {
  final Widget iconWidget;
  final String label;
  final VoidCallback? onPressed;

  const _ButtonData({
    required this.iconWidget,
    required this.label,
    this.onPressed,
  });
}

class RightButtons extends StatefulWidget {
  final int selectedTripIndex;

  const RightButtons({
    super.key,
    this.selectedTripIndex = 0,
    required currentTripCategory,
  });

  @override
  State<RightButtons> createState() => _RightButtonsState();
}

class _RightButtonsState extends State<RightButtons> {
  int selectedIndex = -1;
  late FocusScopeNode _focusScopeNode;
  DateTime? _selectedFilterDate;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
    _focusScopeNode.addListener(() {
      if (!_focusScopeNode.hasFocus && selectedIndex != -1) {
        setState(() => selectedIndex = -1);
      }
    });
    context.read<GetTripBloc>().add(FetchTrips());
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultIconColor = Colors.white;
    const Color selectedIconColor = Colors.blue;

    final List<_ButtonData> buttons = [];
    final tripState = context.watch<GetTripBloc>().state;

    if (tripState is! GetTripLoaded || tripState.trips.isEmpty) {
      return const SizedBox();
    }

    final trip = tripState.trips[widget.selectedTripIndex];
    final bool showHotel = trip.hasHotel == true || trip.hasHotel == 1;
    final bool showCar = trip.hasCar == true || trip.hasCar == 1;
    final bool showActivity = trip.hasActivity;

    // Get the category value from the trip (converting from string if needed)
    final int categoryValue = int.tryParse(trip.category.toString()) ?? 0;

    // Category Button

    buttons.add(
      _ButtonData(
        iconWidget: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0),
          child: Icon(
            Icons.diamond_outlined,
            color: _getColorForCategory(categoryValue),
          ),
        ),
        label: AppLocalizations.of(context)!.category,
        onPressed: () async {
          final int? selectedCategoryValue = await showDialog<int>(
            context: context,
            builder:
                (context) =>
                    CategoryCard(initialSelectedCategory: categoryValue),
          );
          if (selectedCategoryValue != null) {
            setState(() {
              selectedIndex = buttons.length;
              _selectedFilterDate = null;
            });
            context.read<GetTripBloc>().add(
              FilterTripsByCategoryEvent(categoryId: selectedCategoryValue),
            );
            _focusScopeNode.unfocus();
          }
        },
      ),
    );

    // Rest of your button code remains the same...
    // Date Button
    // In the RightButtons widget, update the date button part:
    if (trip.fromDate.isNotEmpty && trip.toDate.isNotEmpty) {
      buttons.add(
        _ButtonData(
          iconWidget: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                trip.hasFly == true || trip.hasFly == 1
                    ? Icons.flight
                    : Icons.calendar_today,
                size: 30,
                color:
                    selectedIndex == buttons.length
                        ? selectedIconColor
                        : defaultIconColor,
              ),
              if (trip.hasFly == true || trip.hasFly == 1)
                Positioned(
                  bottom: 0,
                  child: Text(
                    _selectedFilterDate != null
                        ? DateFormat('d').format(_selectedFilterDate!)
                        : DateFormat('d').format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [Shadow(color: Colors.white, blurRadius: 2)],
                    ),
                  ),
                ),
            ],
          ),
          label:
              trip.hasFly == true || trip.hasFly == 1
                  ? AppLocalizations.of(context)!.fly
                  : AppLocalizations.of(context)!.date,
          onPressed: () async {
            try {
              final firstDate = DateTime.parse(trip.fromDate);
              final lastDate = DateTime.parse(trip.toDate);

              // إضافة تحقق مبدئي
              if (firstDate.isAfter(lastDate)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تواريخ الرحلة غير صالحة")),
                );
                return;
              }

              final result = await showDialog<Map<String, DateTime>>(
                context: context,
                builder:
                    (context) => DateCard(
                      firstDate: firstDate,
                      lastDate: lastDate,
                      initialRangeStart: _selectedFilterDate,
                      initialRangeEnd:
                          _selectedFilterDate != null
                              ? _selectedFilterDate!.add(
                                const Duration(days: 1),
                              )
                              : firstDate.add(
                                const Duration(days: 1),
                              ), // قيمة افتراضية أفضل
                    ),
              );

              if (result != null) {
                // إضافة تحقق نهائي
                if (result['range_start']!.isBefore(firstDate) ||
                    result['range_end']!.isAfter(lastDate)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("الفترة المحددة غير صالحة")),
                  );
                  return;
                }

                setState(() => _selectedFilterDate = result['range_start']);
                context.read<GetTripBloc>().add(
                  FilterTripsByDateRangeEvent(
                    startDate: result['range_start']!,
                    endDate: result['range_end']!,
                  ),
                );
              }
            } catch (e) {
              debugPrint('Date selection error: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('حدث خطأ في اختيار التاريخ')),
              );
            }
          },
        ),
      );
    }

    // Hotel Button
    if (showHotel) {
      buttons.add(
        _ButtonData(
          iconWidget: Icon(
            Icons.hotel,
            color:
                selectedIndex == buttons.length
                    ? selectedIconColor
                    : defaultIconColor,
          ),
          label: AppLocalizations.of(context)!.hotel,
          onPressed: () async {
            final state = context.read<GetTripBloc>().state;
            if (state is GetTripLoaded) {
              await showDialog(
                context: context,
                builder:
                    (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Hotels(hotelTrips: [trip]),
                    ),
              );
            }
          },
        ),
      );
    }

    // Car Button
    // Car Button
    if (showCar) {
      buttons.add(
        _ButtonData(
          iconWidget: Icon(
            Icons.directions_car,
            color:
                selectedIndex == buttons.length
                    ? selectedIconColor
                    : defaultIconColor,
          ),
          label: AppLocalizations.of(context)!.car,
          onPressed: () async {
            final Carmodel? selectedCar = await showDialog<Carmodel>(
              context: context,
              builder:
                  (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    insetPadding: const EdgeInsets.all(20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.16,
                      ),
                      child: const CarSelectionPage(),
                    ),
                  ),
            );
            if (selectedCar != null) {
              debugPrint('Selected Car: ${selectedCar.title}');

              // افتح صفحة الأنشطة بعد اختيار السيارة
              await showDialog(
                context: context,
                builder: (context) => const ActivitiesListDialog(),
              );
            }
          },
        ),
      );
    }

    // Activities Button
    if (trip.hasActivity) {
      buttons.add(
        _ButtonData(
          iconWidget: Icon(
            Icons.category_outlined,
            color:
                selectedIndex == buttons.length
                    ? selectedIconColor
                    : defaultIconColor,
          ),
          label: AppLocalizations.of(context)!.activities,
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => const ActivitiesListDialog(),
            );
          },
        ),
      );
    }

    // Save Button
    buttons.add(
      _ButtonData(
        iconWidget: Icon(
          Icons.bookmark_border,
          color:
              selectedIndex == buttons.length
                  ? selectedIconColor
                  : defaultIconColor,
        ),
        label: AppLocalizations.of(context)!.save,
        onPressed: () => debugPrint('Save pressed'),
      ),
    );

    // Info Button
    buttons.add(
      _ButtonData(
        iconWidget: Icon(
          Icons.info_outline,
          color:
              selectedIndex == buttons.length
                  ? selectedIconColor
                  : defaultIconColor,
        ),
        label: AppLocalizations.of(context)!.info,
        onPressed: () async {
          await showDialog(
            context: context,
            builder:
                (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InfoCard(trip: trip),
                ),
          );
        },
      ),
    );

    return FocusScope(
      node: _focusScopeNode,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // تغيير من spaceAround إلى center
        mainAxisSize: MainAxisSize.min, // تغيير إلى min لتجنب المسافات الزائدة
        children: List.generate(buttons.length, (index) {
          final buttonData = buttons[index];
          return SelectRightButton(
            iconWidget: buttonData.iconWidget,
            label: buttonData.label,
            isSelected: selectedIndex == index,
            onPressed: () {
              _focusScopeNode.requestFocus();
              setState(() => selectedIndex = index);
              buttonData.onPressed?.call();
            },
          );
        }),
      ),
    );
  }
}
