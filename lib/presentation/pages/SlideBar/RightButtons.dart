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
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? buildTripSummary(
  BuildContext context,
  bool showHotel,
  bool showCar,
  bool showActivity,
) {
  final loc = AppLocalizations.of(context)!;
  List<String> parts = [];
  if (showHotel) parts.add(loc.hotel);
  if (showCar) parts.add(loc.car);
  if (showActivity) parts.add(loc.activities);
  if (parts.isEmpty) return null;
  final itemsList = parts.join(", ");
  return loc.priceInfo(itemsList);
}

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
  final int tripId;
  final GlobalKey<PersonCounterWithPriceState>? personCounterKey;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime?, DateTime?)? onDateRangeSelected;
  final Function(int?, double)? onHotelSelected;
  final Function(int?, double)? onCarSelected;
  final Function(int?, double)? onActivitySelected;
  final Function(int?, double)? onFlightSelected;
  final int? selectedHotelId;
  final int? selectedCarId;
  final int? selectedActivityId;
  final int? selectedFlightId;
  final Function(String?)? onSummaryReady; // 🌟 إضافة الـ Callback الجديد

  final String? selectedTripSummary; // 🆕 لإضافة النص من الأب

  const RightButtons({
    super.key,
    required this.tripId,
    required currentTripCategory,
    this.personCounterKey,
    this.startDate,
    this.endDate,
    this.onDateRangeSelected,
    this.onHotelSelected,
    this.onCarSelected,
    this.onActivitySelected,
    this.onFlightSelected,
    this.selectedHotelId,
    this.selectedCarId,
    this.selectedActivityId,
    this.selectedFlightId,
    this.onSummaryReady, // 🌟 يجب إضافته هنا أيضاً

    this.selectedTripSummary, // 🆕 إضافته هنا أيضاً
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
  double selectedHotelPrice = 0.0;
  double selectedCarPrice = 0.0;
  double selectedActivityPrice = 0.0;
  int? selectedFlightId;
  double selectedFlightPrice = 0.0;

  // ✅ مفاتيح ShowcaseView
  final GlobalKey _categoryKey = GlobalKey();
  final GlobalKey _dateKey = GlobalKey();
  final GlobalKey _hotelKey = GlobalKey();
  final GlobalKey _carKey = GlobalKey();
  final GlobalKey _activitiesKey = GlobalKey();
  final GlobalKey _saveKey = GlobalKey();
  final GlobalKey _infoKey = GlobalKey();

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startShowcase();
    });
  }

  void _startShowcase() async {
    final prefs = await SharedPreferences.getInstance();
    final bool showcaseShown = prefs.getBool('showcase_shown') ?? false;

    if (!showcaseShown) {
      ShowCaseWidget.of(context).startShowCase([
        _categoryKey,
        _dateKey,
        _hotelKey,
        _carKey,
        _activitiesKey,
        _saveKey,
        _infoKey,
      ]);
      prefs.setBool('showcase_shown', true);
    }
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
    final trip = tripState.trips.firstWhere(
      (t) => t.id == widget.tripId,
      orElse: () => tripState.trips.first,
    );

    final int categoryValue = int.tryParse(trip.category.toString()) ?? 0;

    final bool showHotel = trip.hasHotel == true || trip.hasHotel == 1;
    final bool showCar = trip.hasCar == true || trip.hasCar == 1;
    final bool showActivity = trip.hasActivity == true || trip.hasActivity == 1;

    debugPrint(
      'Trip Features: Hotel=$showHotel, Car=$showCar, Activity=$showActivity',
    );
    // 🌟 هذا الاستدعاء صحيح الآن لأن الدالة في نطاق الملف العام
    final String? tripSummary = buildTripSummary(
      context,
      showHotel,
      showCar,
      showActivity,
    );
    // 🌟🌟 استدعاء الـ Callback هنا ليعود النص للشاشة الأب
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSummaryReady?.call(tripSummary);
    });
    debugPrint('RightButtons Callback Fired. Summary: $tripSummary');

    ///////////////////////////////////////////////
    /// Category Button
    ///
    buttons.add(
      _ButtonData(
        iconWidget: Showcase(
          // ✅ إضافة Showcase هنا
          key: _categoryKey,
          description:
              AppLocalizations.of(context)!.showcaseCategoryDescription,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(-1.0, 1.0),
            child: Icon(
              Icons.diamond_outlined,
              color: _getColorForCategory(categoryValue),
            ),
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

    ///////////////////////////////////////////////
    /// Date Button
    ///
    if (trip.fromDate.isNotEmpty && trip.toDate.isNotEmpty) {
      buttons.add(
        _ButtonData(
          iconWidget: Showcase(
            key: _dateKey,
            description: AppLocalizations.of(context)!.showcaseDateDescription,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  (trip.hasFly == true || trip.hasFly == 1)
                      ? Icons.flight
                      : Icons.calendar_today,
                  size: 30,
                  color:
                      selectedIndex == buttons.length
                          ? Colors.white
                          : Colors.white,
                ),
                if (trip.hasFly == true || trip.hasFly == 1)
                  Positioned(
                    bottom: 0,
                    child: Text(
                      _rangeStart != null
                          ? DateFormat('d').format(_rangeStart!)
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
          ),
          label:
              (trip.hasFly == true || trip.hasFly == 1)
                  ? AppLocalizations.of(context)!.fly
                  : AppLocalizations.of(context)!.date,
          onPressed: () async {
            try {
              // 🆕 نأخذ أول تاريخ من المصفوفة كنطاق بداية متاح
              final firstDateStr = trip.fromDate.first;
              // 🆕 نأخذ آخر تاريخ من المصفوفة كنطاق نهاية متاح
              final lastDateStr = trip.toDate.last;

              final firstDate = DateTime.parse(firstDateStr);
              final lastDate = DateTime.parse(lastDateStr);

              if (firstDate.isAfter(lastDate)) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تواريخ الرحلة غير صالحة")),
                );
                return;
              }

              final result = await showDialog<Map<String, DateTime>?>(
                context: context,
                builder:
                    (context) => BlocProvider(
                      create: (context) => DateSelectionBloc(),
                      child: DateCard(
                        firstDate: trip.overallMinFromDate,
                        lastDate: trip.overallMaxToDate,

                        initialRangeStart: _rangeStart,
                        initialRangeEnd: _rangeEnd,

                        availableFromDates:
                            trip.fromDate, // 🆕 تمرير القوائم الجديدة
                        availableToDates:
                            trip.toDate, // 🆕 تمرير القوائم الجديدة
                      ),
                    ),
              );

              if (result != null) {
                final DateTime? newRangeStart = result['range_start'];
                final DateTime? newRangeEnd = result['range_end'];

                setState(() {
                  _rangeStart = newRangeStart;
                  _rangeEnd = newRangeEnd;
                });

                // 🆕 استدعاء الـ callback لتمرير البيانات إلى VideoPlayerScreen
                if (_rangeStart != null && _rangeEnd != null) {
                  final fromDate = DateFormat(
                    'yyyy-MM-dd',
                  ).format(_rangeStart!);
                  final toDate = DateFormat('yyyy-MM-dd').format(_rangeEnd!);

                  widget.onDateRangeSelected?.call(
                    DateTime.parse(fromDate),
                    DateTime.parse(toDate),
                  );

                  print("✅ Date selected: from=$fromDate to=$toDate");
                }
                // 🆕 يمكنك هنا استدعاء Bloc لتصفية الرحلات إذا لزم الأمر

                // 🆕 افتح أول زر بعد التاريخ
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

    ///////////////////////////
    //////////////////
    /// Hotel Button ///
    if (showHotel) {
      buttons.add(
        _ButtonData(
          iconWidget: Showcase(
            key: _hotelKey,
            description: AppLocalizations.of(context)!.showcaseHotelDescription,
            child: Icon(
              Icons.hotel,
              color:
                  selectedIndex == buttons.length
                      ? selectedIconColor
                      : defaultIconColor,
            ),
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
                          // repository: HotelsRepository(),
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

            // ✅ اعمل check الأول
            if (selectedHotel != null) {
              final int nights =
                  _rangeStart != null && _rangeEnd != null
                      ? _rangeEnd!.difference(_rangeStart!).inDays
                      : 1;

              // 🆕 استدعاء الـ callback بعد التأكد إنه مش null
              widget.onHotelSelected?.call(
                selectedHotel.id,
                selectedHotel.pricePerNight * nights,
              );

              widget.personCounterKey?.currentState?.setSelectedHotelPrice(
                selectedHotel.pricePerNight,
                nights,
              );

              setState(() {
                selectedHotelId = selectedHotel.id;
                selectedHotelPrice = selectedHotel.pricePerNight * nights;
              });

              print(
                "✅ Hotel Selected: id=$selectedHotelId, price=$selectedHotelPrice",
              );

              // 🔹 تحديد الزر الحالي للـ Hotel
              final currentIndex = buttons.indexWhere(
                (b) => b.label == AppLocalizations.of(context)!.hotel,
              );
              final nextButtonIndex = currentIndex + 1;

              if (nextButtonIndex < buttons.length) {
                setState(() {
                  selectedIndex = nextButtonIndex;
                });
                buttons[nextButtonIndex].onPressed?.call();
              }
            }
          },
        ),
      );
    }

    ///////////////////////////////////////////////
    ///Car Button
    ///

    if (showCar) {
      buttons.add(
        _ButtonData(
          iconWidget: Showcase(
            // ✅ إضافة Showcase هنا
            key: _carKey,
            description: AppLocalizations.of(context)!.showcaseCarDescription,
            child: Icon(
              Icons.directions_car,
              color:
                  selectedIndex == buttons.length
                      ? selectedIconColor
                      : defaultIconColor,
            ),
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
                  child: CarSelectionPage(
                    selectedCarId: selectedCarId,
                    personCounterKey: widget.personCounterKey, // ✅ ده المهم
                  ),
                );
              },
            );

            if (selectedCarFromDialog != null) {
              // 🆕 استدعاء الـ callback لتمرير البيانات للـ VideoPlayerScreen
              widget.onCarSelected?.call(
                selectedCarFromDialog.id,
                selectedCarFromDialog.price,
              );

              setState(() {
                selectedCarId = selectedCarFromDialog.id;
                selectedCar = selectedCarFromDialog;
                selectedCarPrice = selectedCarFromDialog.price; // ✅
              });
              print(
                "✅ Car Selected: id=$selectedCarId, price=$selectedCarPrice",
              );

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
                            personCounterKey: widget.personCounterKey,
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
                    selectedActivityPrice = price;
                  });
                  print(
                    "✅ Activity Selected: id=$selectedActivityId, price=$selectedActivityPrice",
                  );

                  // 🆕 هنا تضيف الكولباك عشان يوصل للـ VideoPlayerScreen
                  widget.onActivitySelected?.call(
                    selectedActivityFromDialog.id,
                    price,
                  );

                  widget.personCounterKey?.currentState
                      ?.setSelectedActivityPrice(price);
                }
              }
            }
          },
        ),
      );
    }

    ///////////////////////////////////////////
    //// Activities Button
    ///

    if (trip.hasActivity) {
      buttons.add(
        _ButtonData(
          iconWidget: Showcase(
            // ✅ إضافة Showcase هنا
            key: _activitiesKey,
            description:
                AppLocalizations.of(context)!.showcaseActivitiesDescription,
            child: Icon(
              Icons.category_outlined,
              color:
                  selectedIndex == buttons.length
                      ? selectedIconColor
                      : defaultIconColor,
            ),
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
              // 🆕 استدعاء الـ callback لتمرير البيانات للـ VideoPlayerScreen
              widget.onActivitySelected?.call(
                selectedActivityFromDialog.id,
                price,
              );

              setState(() {
                selectedActivityId =
                    selectedActivityId = selectedActivityFromDialog.id;
                selectedActivityPrice = price; // ✅
              });
              widget.personCounterKey?.currentState?.setSelectedActivityPrice(
                price,
              );
            }
          },
        ),
      );
    }

    /////////////////////////////////////////
    /// Save Button
    ///

    buttons.add(
      _ButtonData(
        iconWidget: Showcase(
          // ✅ إضافة Showcase هنا
          key: _saveKey,
          description: AppLocalizations.of(context)!.showcaseSaveDescription,
          child: Icon(
            Icons.bookmark_border,
            color:
                selectedIndex == buttons.length
                    ? selectedIconColor
                    : defaultIconColor,
          ),
        ),
        label: AppLocalizations.of(context)!.save,
        onPressed: () => debugPrint('Save pressed'),
      ),
    );

    ///////////////////////////////
    /// Info Button
    ///
    buttons.add(
      _ButtonData(
        iconWidget: Showcase(
          // ✅ إضافة Showcase هنا
          key: _infoKey,
          description: AppLocalizations.of(context)!.showcaseInfoDescription,
          child: Icon(
            Icons.info_outline,
            color:
                selectedIndex == buttons.length
                    ? selectedIconColor
                    : defaultIconColor,
          ),
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
                  child: InfoCard(
                    trip: trip,
                    tripSummaryText:
                        widget.selectedTripSummary, // 🆕 تمرير النص
                  ),
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
