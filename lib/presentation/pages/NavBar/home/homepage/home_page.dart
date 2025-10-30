import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/ActivityPage/activities_page.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/AllCars.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/VedioPlayerPage.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/WebDrawer.dart';
import 'package:tripto/presentation/pages/NavBar/hotel/HotelCard.dart';
import 'package:tripto/presentation/pages/SlideBar/RightButtons.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';

import '../../../../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final GlobalKey<VideoPlayerScreenState> videoPlayerScreenKey = GlobalKey();
  bool _isDrawerOpen = true;
  int _currentTripId = 1;
  int _currentTripCategory = 0;
  GlobalKey<PersonCounterWithPriceState> _currentPersonCounterKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  String? _tripSummaryText;
  int? _selectedHotelId;
  double _selectedHotelPrice = 0.0;
  int? _selectedCarId;
  double _selectedCarPrice = 0.0;
  int? _selectedActivityId;
  double _selectedActivityPrice = 0.0;

  void _updateCurrentTripDetails(
    int tripId,
    int category,
    GlobalKey<PersonCounterWithPriceState> personCounterKey,
    String? tripSummary,
    int? hotelId,
    double hotelPrice,
    int? carId,
    double carPrice,
    int? activityId,
    double activityPrice,
  ) {
    setState(() {
      _currentTripId = tripId;
      _currentTripCategory = category;
      _currentPersonCounterKey = personCounterKey;
      _tripSummaryText = tripSummary;
      _selectedHotelId = hotelId;
      _selectedHotelPrice = hotelPrice;
      _selectedCarId = carId;
      _selectedCarPrice = carPrice;
      _selectedActivityId = activityId;
      _selectedActivityPrice = activityPrice;
    });
  }

  void _updateTripSummary(String? summary) {
    if (!mounted) return;
    if (summary != _tripSummaryText) {
      setState(() {
        _tripSummaryText = summary;
      });
      debugPrint("✅ Summary received in HomePage: $summary");
    }
  }

  void toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void onDateRangeSelected(DateTime? start, DateTime? end) {
    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
    });
    debugPrint("📅 Date Range Updated -> From: $start, To: $end");
  }

  void _scrollToNextPage() {
    final state = videoPlayerScreenKey.currentState;
    if (state != null && (state as dynamic).nextPage is Function) {
      (state as dynamic).nextPage();
    }
  }

  void _scrollToPreviousPage() {
    final state = videoPlayerScreenKey.currentState;
    if (state != null && (state as dynamic).previousPage is Function) {
      (state as dynamic).previousPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return LayoutBuilder(
      builder: (context, constraints) {
        const double tabletBreakpoint = 600;

        if (constraints.maxWidth > tabletBreakpoint && kIsWeb) {
          const double videoWidth = 450;
          const double rightButtonsWidth = 280;
          const double scrollButtonsWidth = 100;
          const double spacingBetween = 40;

          final screenWidth = constraints.maxWidth;
          final remainingSpace =
              (screenWidth -
                  (videoWidth +
                      rightButtonsWidth +
                      scrollButtonsWidth +
                      spacingBetween * 2)) /
              2;

          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.black,
            drawerScrimColor: Colors.transparent,
            drawerEnableOpenDragGesture: false,
            endDrawerEnableOpenDragGesture: false,
            body: Stack(
              children: [
                // 🎬 المحتوى الرئيسي
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: remainingSpace),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: videoWidth,
                          maxHeight: 850,
                        ),
                        child: VideoPlayerScreen(
                          key: videoPlayerScreenKey,
                          onTripChanged: _updateCurrentTripDetails,
                        ),
                      ),
                      const SizedBox(width: spacingBetween),
                      SizedBox(
                        width: rightButtonsWidth,
                        child: RightButtons(
                          tripId: _currentTripId,
                          currentTripCategory: _currentTripCategory,
                          personCounterKey: _currentPersonCounterKey,
                          selectedTripSummary: _tripSummaryText,
                          onHotelSelected: (id, price) {
                            if (!mounted) return;
                            setState(() {
                              _selectedHotelId = id;
                              _selectedHotelPrice = price;
                            });
                          },
                          onCarSelected: (id, price) {
                            if (!mounted) return;
                            setState(() {
                              _selectedCarId = id;
                              _selectedCarPrice = price;
                            });
                          },
                          onActivitySelected: (id, price) {
                            if (!mounted) return;
                            setState(() {
                              _selectedActivityId = id;
                              _selectedActivityPrice = price;
                            });
                          },
                          onFlightSelected: (id, price) {},
                          onSummaryReady: _updateTripSummary,
                          onDateRangeSelected: onDateRangeSelected,
                        ),
                      ),
                      const SizedBox(width: spacingBetween),
                      SizedBox(
                        width: scrollButtonsWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_up,
                                size: 40,
                                color: Colors.white70,
                              ),
                              onPressed: _scrollToPreviousPage,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white10,
                              ),
                            ),
                            const SizedBox(height: 20),
                            IconButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 40,
                                color: Colors.white70,
                              ),
                              onPressed: _scrollToNextPage,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 🟥 Drawer
                if (_isDrawerOpen)
                  Positioned(
                    top: 70,
                    left: isArabic ? null : 20,
                    right: isArabic ? 20 : null,
                    bottom: 0,
                    child: SizedBox(width: 300, child: const WebDrawer()),
                  ),

                if (!_isDrawerOpen)
                  Positioned(
                    left: isArabic ? null : 20,
                    right: isArabic ? 20 : null,
                    top: 90,
                    child: Column(
                      children: [
                        _buildIcon(
                          context,
                          Icons.home,
                          AppLocalizations.of(context)!.home,
                          const HomePage(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        _buildIcon(
                          context,
                          Icons.hotel,
                          AppLocalizations.of(context)!.hotels,
                          const Hotelcard(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        _buildIcon(
                          context,
                          Icons.extension,
                          AppLocalizations.of(context)!.activities,
                          const ActivityPage(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        _buildIcon(
                          context,
                          Icons.car_rental,
                          AppLocalizations.of(context)!.cars,
                          const CarCard(),
                        ),
                      ],
                    ),
                  ),

                Positioned(
                  left: isArabic ? null : 20,
                  right: isArabic ? 20 : null,
                  top: 20,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: toggleDrawer,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                      Image.asset(
                        'assets/images/TRIPTO.png',
                        height: 58,
                        width: 75,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: VideoPlayerScreen(),
          );
        }
      },
    );
  }

  Widget _buildIcon(
    BuildContext context,
    IconData icon,
    String label,
    Widget page,
  ) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white, size: 22),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
        ),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
