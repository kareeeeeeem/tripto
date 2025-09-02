import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tripto/bloc&repo/Hotel/hotelEvents.dart';
import 'package:tripto/bloc&repo/Hotel/hotelRep.dart';
import 'package:tripto/bloc&repo/car/car_bloc.dart';
import 'package:tripto/bloc&repo/car/car_event.dart';
import 'package:tripto/bloc&repo/car/car_repository.dart';
import 'package:tripto/bloc&repo/date/date_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_event.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_state.dart';
import 'package:tripto/core/constants/SelectRightButton.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/bloc&repo/Hotel/hotelBloc.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import 'package:tripto/presentation/pages/SlideBar/activity/ActivityListDialog.dart';
import 'package:tripto/presentation/pages/SlideBar/car/CarDialog.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryCard.dart';
import 'package:tripto/presentation/pages/SlideBar/date/DateCard.dart';
import 'package:tripto/presentation/pages/SlideBar/info/InfoCard.dart';
import 'package:tripto/presentation/pages/SlideBar/hotel/HotelsCard.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';

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
  final GlobalKey<PersonCounterWithPriceState>? personCounterKey;
  final DateTime? startDate; // ← جديد
  final DateTime? endDate;

  RightButtons({
    super.key,
    this.selectedTripIndex = 0,
    required currentTripCategory,
    this.personCounterKey, // ← أضف هذا

    this.startDate,
    this.endDate,
  });

  @override
  State<RightButtons> createState() => _RightButtonsState();
}

class _RightButtonsState extends State<RightButtons> {
  int selectedIndex = -1;
  late FocusScopeNode _focusScopeNode;
  DateTime? _selectedFilterDate;
  Carmodel? selectedCar;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  int? selectedHotelId;
  int? selectedCarId;
  int? selectedActivityId; // ✅ جديد

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
    _focusScopeNode.addListener(() {
      if (!_focusScopeNode.hasFocus && selectedIndex != -1) {
        setState(() => selectedIndex = -1);
      }
    });
    context.read<TripBloc>().add(FetchTrips());
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
    final tripState = context.watch<TripBloc>().state;

    if (tripState is! TripLoaded || tripState.trips.isEmpty) {
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
            context.read<TripBloc>().add(
              FilterTripsByCategoryEvent(selectedCategoryValue),
            );
            _focusScopeNode.unfocus();
          }
        },
      ),
    );

    // Date Button
    if (trip.fromDate.isNotEmpty && trip.toDate.isNotEmpty) {
      buttons.add(
        _ButtonData(
          iconWidget: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                (trip.hasFly == true || trip.hasFly == 1)
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
                        : '', // لو فاضي ما يظهرش أي رقم
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
              (trip.hasFly == true || trip.hasFly == 1)
                  ? AppLocalizations.of(context)!.fly
                  : AppLocalizations.of(context)!.date,
          onPressed: () async {
            try {
              final firstDate = DateTime.parse(trip.fromDate);
              final lastDate = DateTime.parse(trip.toDate);

              if (firstDate.isAfter(lastDate)) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تواريخ الرحلة غير صالحة")),
                );
                return;
              }

              final result = await showDialog<Map<String, DateTime>>(
                context: context,
                builder:
                    (context) => BlocProvider(
                      create: (context) => DateSelectionBloc(),
                      child: DateCard(
                        firstDate: firstDate,
                        lastDate: lastDate,
                        initialRangeStart: _selectedFilterDate,
                        initialRangeEnd:
                            _selectedFilterDate != null
                                ? _selectedFilterDate!.add(
                                  const Duration(days: 1),
                                )
                                : firstDate.add(const Duration(days: 1)),
                      ),
                    ),
              );

              if (result != null) {
                setState(() {
                  _selectedFilterDate = result['range_start'];
                  _rangeStart = result['range_start'];
                  _rangeEnd = result['range_end'];
                });

                context.read<TripBloc>().add(
                  FilterTripsByDateRangeEvent(_rangeStart!, _rangeEnd!),
                );

                // افتح أول زر بعد التاريخ
                Future.delayed(const Duration(milliseconds: 300), () {
                  final int dateButtonIndex = buttons.indexWhere(
                    (b) =>
                        b.label == AppLocalizations.of(context)!.date ||
                        b.label == AppLocalizations.of(context)!.fly,
                  );
                  final List<_ButtonData> postDateButtons = buttons.sublist(
                    dateButtonIndex + 1,
                  );

                  for (final button in postDateButtons) {
                    if (button.onPressed != null) {
                      button.onPressed!.call();
                      break;
                    }
                  }
                });
              }
            } catch (e) {
              debugPrint('Date selection error: $e');
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('حدث خطأ في اختيار التاريخ')),
              );
            }
          },
        ),
      );
    }
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
            final selectedHotel = await showDialog(
              context: context,
              builder:
                  (context) => BlocProvider(
                    create:
                        (_) => HotelsBloc(
                          hotelsRepository: HotelsRepository(),
                        )..add(
                          FetchHotels(subDestinationId: trip.subDestinationId!),
                        ),
                    child: HotelsDialog(
                      subDestinationId: trip.subDestinationId!,
                      personCounterKey: widget.personCounterKey,
                      startDate: _rangeStart,
                      endDate: _rangeEnd,
                      nextSteps: [],
                      selectedHotelId: selectedHotelId,
                    ),
                  ),
            );

            final int nights =
                _rangeStart != null && _rangeEnd != null
                    ? _rangeEnd!.difference(_rangeStart!).inDays
                    : 1;

            if (selectedHotel != null) {
              // ✅ Continue → خزّن الفندق واضبط السعر
              setState(() {
                selectedHotelId = selectedHotel.id;
              });

              widget.personCounterKey?.currentState?.setSelectedHotelPrice(
                selectedHotel.pricePerNight,
                nights,
              );

              // 🔹 تحديد الزر الحالي للـ Hotel
              final currentIndex = buttons.indexWhere(
                (b) => b.label == AppLocalizations.of(context)!.hotel,
              );
              final nextButtonIndex = currentIndex + 1;

              if (nextButtonIndex < buttons.length) {
                // فتح الزر التالي مباشرة
                setState(() {
                  selectedIndex = nextButtonIndex;
                });
                buttons[nextButtonIndex].onPressed?.call();
              }
              // } else {
              //   // ❌ Cancel → مسح الفندق واضبط السعر بـ 0
              //   setState(() {
              //     selectedHotelId = null;
              //   });

              //   widget.personCounterKey?.currentState?.setSelectedHotelPrice(
              //     0,
              //     nights,
              //   );
            }
          },
        ),
      );
    }
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
            final Carmodel? selectedCarFromDialog = await showDialog<Carmodel>(
              context: context,
              builder: (dialogContext) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: BlocProvider.of<TripBloc>(context),
                    ),
                    BlocProvider(
                      create:
                          (_) => CarBloc(CarRepository())..add(
                            LoadCars(
                              subDestinationId: trip.subDestinationId!,
                              category: trip.category,
                            ),
                          ),
                    ),
                  ],
                  child: CarSelectionPage(selectedCarId: selectedCarId),
                );
              },
            );

            if (selectedCarFromDialog != null) {
              setState(() {
                selectedCarId = selectedCarFromDialog.id;
                selectedCar = selectedCarFromDialog;
              });
              widget.personCounterKey?.currentState?.setSelectedCarPrice(
                selectedCarFromDialog.price,
              );
              if (trip.hasActivity) {
                final selectedActivityFromDialog =
                    await showDialog<GetActivityModel>(
                      context: context,
                      builder:
                          (context) => ActivitiesListDialog(
                            initialSelectedActivityId: selectedActivityId,
                            personCounterKey: widget.personCounterKey, // ✅ هنا
                            // ✅ تم إضافة هذا السطر
                          ),
                    );
                if (selectedActivityFromDialog != null) {
                  final price =
                      double.tryParse(
                        selectedActivityFromDialog.price.toString(),
                      ) ??
                      0.0;
                  setState(() {
                    selectedActivityId =
                        selectedActivityFromDialog.id; // ✅ تم حفظ المعرف هنا
                  });
                  widget.personCounterKey?.currentState
                      ?.setSelectedActivityPrice(price);
                }
                // else {
                //   setState(() {
                //     selectedActivityId = null;
                //   });
                //   widget.personCounterKey?.currentState
                //       ?.setSelectedActivityPrice(0);
                // }

                // } else {
                //   setState(() {
                //     selectedCarId = null;
                //     selectedCar = null;
                //   });
                //widget.personCounterKey?.currentState?.setSelectedCarPrice(0);
                // }
              }
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
            final selectedActivityFromDialog =
                await showDialog<GetActivityModel>(
                  context: context,
                  builder:
                      (context) => ActivitiesListDialog(
                        initialSelectedActivityId: selectedActivityId,
                        personCounterKey:
                            widget.personCounterKey, // ✅ لازم يبقى موجود
                        // ✅ تم إضافة هذا السطر
                      ),
                );

            if (selectedActivityFromDialog != null) {
              final price =
                  double.tryParse(
                    selectedActivityFromDialog.price.toString(),
                  ) ??
                  0.0;
              setState(() {
                selectedActivityId =
                    selectedActivityFromDialog.id; // ✅ تم حفظ المعرف هنا
              });
              widget.personCounterKey?.currentState?.setSelectedActivityPrice(
                price,
              );
            } else {
              // setState(() {
              //   selectedActivityId = null;
              // });
              // widget.personCounterKey?.currentState?.setSelectedActivityPrice(
              //   0,
              // );
            }
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
