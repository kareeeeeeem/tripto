import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_event.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_state.dart';
import 'package:tripto/bloc&repo/Hotel/hotelEvents.dart';
import 'package:tripto/bloc&repo/car/car_event.dart';
import 'package:tripto/core/constants/SelectRightButton.dart';
import 'package:tripto/presentation/pages/SlideBar/info/InfoCard.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';
import 'package:tripto/presentation/pages/SlideBar/activity/ActivityListDialog.dart';
import 'package:tripto/presentation/pages/SlideBar/car/CarDialog.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryCard.dart';
import 'package:tripto/presentation/pages/SlideBar/date/DateCard.dart';
import 'package:tripto/presentation/pages/SlideBar/hotel/HotelsCard.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import 'package:tripto/bloc&repo/Hotel/hotelBloc.dart';
import 'package:tripto/bloc&repo/Hotel/hotelRep.dart';
import 'package:tripto/bloc&repo/date/date_bloc.dart';
import 'package:tripto/bloc&repo/car/car_bloc.dart';
import 'package:tripto/bloc&repo/car/car_repository.dart';

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
  final DateTime? startDate;
  final DateTime? endDate;

  const RightButtons({
    super.key,
    this.selectedTripIndex = 0,
    this.personCounterKey,
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
  int? selectedActivityId;

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

    return BlocListener<TripBloc, TripState>(
      listener: (context, state) {
        if (state is TripLoaded && state.trips.isNotEmpty) {
          final safeIndex =
              widget.selectedTripIndex.clamp(0, state.trips.length - 1);
          final trip = state.trips[safeIndex];

          setState(() {
            selectedIndex = -1;
            selectedHotelId = null;
            selectedCarId = null;
            selectedActivityId = null;
            _selectedFilterDate = null;
            _rangeStart = null;
            _rangeEnd = null;
            selectedCar = null;
          });
        }
      },
      child: Builder(
        builder: (context) {
          final tripState = context.watch<TripBloc>().state;
          if (tripState is! TripLoaded || tripState.trips.isEmpty) {
            return const SizedBox();
          }

          final safeIndex =
              widget.selectedTripIndex.clamp(0, tripState.trips.length - 1);
          final trip = tripState.trips[safeIndex];
          final bool showHotel = trip.hasHotel == true || trip.hasHotel == 1;
          final bool showCar = trip.hasCar == true || trip.hasCar == 1;
          final bool showActivity = trip.hasActivity;

          final int categoryValue = int.tryParse(trip.category.toString()) ?? 0;

          final List<_ButtonData> buttons = [];

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
                  builder: (context) =>
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
                      color: selectedIndex == buttons.length
                          ? selectedIconColor
                          : defaultIconColor,
                    ),
                    if (trip.hasFly == true || trip.hasFly == 1)
                      Positioned(
                        bottom: 0,
                        child: Text(
                          _selectedFilterDate != null
                              ? DateFormat('d').format(_selectedFilterDate!)
                              : '',
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
                label: (trip.hasFly == true || trip.hasFly == 1)
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
                      builder: (context) => BlocProvider(
                        create: (context) => DateSelectionBloc(),
                        child: DateCard(
                          firstDate: firstDate,
                          lastDate: lastDate,
                          initialRangeStart: _selectedFilterDate,
                          initialRangeEnd: _selectedFilterDate != null
                              ? _selectedFilterDate!.add(const Duration(days: 1))
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

          // Hotel Button
          if (showHotel) {
            buttons.add(
              _ButtonData(
                iconWidget: Icon(
                  Icons.hotel,
                  color: selectedIndex == buttons.length
                      ? selectedIconColor
                      : defaultIconColor,
                ),
                label: AppLocalizations.of(context)!.hotel,
                onPressed: () async {
                  final selectedHotel = await showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (_) => HotelsBloc(
                          hotelsRepository: HotelsRepository())
                        ..add(FetchHotels(subDestinationId: trip.subDestinationId!)),
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

                  final int nights = _rangeStart != null && _rangeEnd != null
                      ? _rangeEnd!.difference(_rangeStart!).inDays
                      : 1;

                  if (selectedHotel != null) {
                    setState(() {
                      selectedHotelId = selectedHotel.id;
                    });

                    widget.personCounterKey?.currentState?.setSelectedHotelPrice(
                      selectedHotel.pricePerNight,
                      nights,
                    );
                  }
                },
              ),
            );
          }

          // Car Button
          if (showCar) {
            buttons.add(
              _ButtonData(
                iconWidget: Icon(
                  Icons.directions_car,
                  color: selectedIndex == buttons.length
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
                            create: (_) => CarBloc(CarRepository())..add(
                                  LoadCars(
                                    subDestinationId: trip.subDestinationId!,
                                    category: trip.category,
                                  ),
                                ),
                          ),
                        ],
                        child: CarSelectionPage(
                          selectedCarId: selectedCarId,
                          personCounterKey: widget.personCounterKey,
                        ),
                      );
                    },
                  );

                  if (selectedCarFromDialog != null) {
                    setState(() {
                      selectedCarId = selectedCarFromDialog.id;
                      selectedCar = selectedCarFromDialog;
                    });

                    widget.personCounterKey?.currentState
                        ?.setSelectedCarPrice(selectedCarFromDialog.price);
                  }
                },
              ),
            );
          }

          // Activities Button
          if (showActivity) {
            buttons.add(
              _ButtonData(
                iconWidget: Icon(
                  Icons.category_outlined,
                  color: selectedIndex == buttons.length
                      ? selectedIconColor
                      : defaultIconColor,
                ),
                label: AppLocalizations.of(context)!.activities,
                onPressed: () async {
                  final selectedActivityFromDialog =
                      await showDialog<GetActivityModel>(
                    context: context,
                    builder: (context) => ActivitiesListDialog(
                      initialSelectedActivityId: selectedActivityId,
                      personCounterKey: widget.personCounterKey,
                    ),
                  );

                  if (selectedActivityFromDialog != null) {
                    final price = double.tryParse(
                          selectedActivityFromDialog.price.toString(),
                        ) ??
                        0.0;
                    setState(() {
                      selectedActivityId = selectedActivityFromDialog.id;
                    });
                    widget.personCounterKey?.currentState
                        ?.setSelectedActivityPrice(price);
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
                color: selectedIndex == buttons.length
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
                color: selectedIndex == buttons.length
                    ? selectedIconColor
                    : defaultIconColor,
              ),
              label: AppLocalizations.of(context)!.info,
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => Dialog(
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
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
        },
      ),
    );
  }
}
