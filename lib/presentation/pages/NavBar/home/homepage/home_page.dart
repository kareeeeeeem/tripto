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
  bool _isDrawerOpen = false;

  int _currentTripId = 1; // قيمة افتراضية
  int _currentTripCategory = 0; // قيمة افتراضية
  GlobalKey<PersonCounterWithPriceState> _currentPersonCounterKey =
      GlobalKey(); // مفتاح افتراضي
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 0));
      if (mounted && kIsWeb) {
        _scaffoldKey.currentState?.openDrawer();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // بيتنادى لما الصفحة ترجع تاني بعد ما كنت فاتح صفحة تانية
  @override
  void didPopNext() {
    if (mounted && kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scaffoldKey.currentState?.openDrawer();
      });
    }
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
            drawer: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  if (_isDrawerOpen)
                    Positioned(
                      top: 70,
                      left: isArabic ? null : 20,
                      right: isArabic ? 20 : null,
                      bottom: 0,
                      child: SizedBox(width: 300, child: const WebDrawer()),
                    ),

                  if (_isDrawerOpen)
                    Positioned(
                      top: 70,
                      left: isArabic ? 0 : 300,
                      right: isArabic ? 300 : 0,
                      bottom: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: const SizedBox(),
                      ),
                    ),

                  Positioned(
                    left: isArabic ? null : 20,
                    right: isArabic ? 20 : null,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              _isDrawerOpen = !_isDrawerOpen;
                            });
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.11,
                        ),

                        // 🔹 اللوجو
                        Image.asset(
                          'assets/images/TRIPTO.png',
                          height: 58,
                          width: 75,
                        ),
                      ],
                    ),
                  ),
                  if (!_isDrawerOpen)
                    Positioned(
                      left: isArabic ? null : 20,
                      right: isArabic ? 20 : null,
                      top: 80,
                      child: AnimatedOpacity(
                        opacity: _isDrawerOpen ? 0 : 1,
                        duration: const Duration(milliseconds: 300),
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.home,
                                color: Colors.white,
                                size: 22,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.home,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.hotel,
                                color: Colors.white,
                                size: 22,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Hotelcard(),
                                  ),
                                );
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.hotels,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.extension,
                                color: Colors.white,
                                size: 22,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ActivityPage(),
                                  ),
                                );
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.activities,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.car_rental_sharp,
                                color: Colors.white,
                                size: 22,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CarCard(),
                                  ),
                                );
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.cars,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            drawerScrimColor: Colors.transparent,
            onDrawerChanged: (isOpened) {
              setState(() {
                _isDrawerOpen = isOpened;
              });
            },

            body: Builder(
              // 💡 2. استخدام Builder للحصول على context الـ Scaffold
              builder: (context) {
                return Stack(
                  // 💡 3. استخدام Stack لوضع زر القائمة فوق المحتوى
                  children: [
                    // المحتوى الرئيسي (الـ Row الممركز)
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: remainingSpace),

                          // 🎬 الفيديو في النص
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

                          // 🎛 RightButtons
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

                          // ⬆⬇ أزرار السحب
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
                    if (_isDrawerOpen)
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {},
                          child: const SizedBox(),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        } else {
          // 📱 للموبايل (من غير RightButtons أو Drawer)
          return const Scaffold(
            backgroundColor: Colors.black,
            body: VideoPlayerScreen(),
          );
        }
      },
    );
  }
}
