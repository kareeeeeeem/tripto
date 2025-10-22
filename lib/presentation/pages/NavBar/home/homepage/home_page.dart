import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/VedioPlayerPage.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/WebDrawer.dart';
import 'package:tripto/presentation/pages/SlideBar/RightButtons.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<VideoPlayerScreenState> videoPlayerScreenKey = GlobalKey();

  int _currentTripId = 1; // قيمة افتراضية
  int _currentTripCategory = 0; // قيمة افتراضية
  GlobalKey<PersonCounterWithPriceState> _currentPersonCounterKey = GlobalKey(); // مفتاح افتراضي

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

// داخل _HomePageState في homepage.dart

void _updateTripSummary(String? summary) {
    if (!mounted) return;
    if (summary != _tripSummaryText) {
        setState(() {
            _tripSummaryText = summary;
        });
        debugPrint("✅ Summary received in HomePage: $summary");

        // 🌟 أهم خطوة: استدعاء دالة تحديث الملخص في VideoPlayerScreenState
        // هذا يعمل لتحديث الشاشة المعروضة على الويب.
        videoPlayerScreenKey.currentState?.updateTripSummaryText(summary); 
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
    return LayoutBuilder(
      builder: (context, constraints) {
        const double tabletBreakpoint = 600;

        if (constraints.maxWidth > tabletBreakpoint && kIsWeb) {
          const double videoWidth = 450;
          const double rightButtonsWidth = 280;
          const double scrollButtonsWidth = 100;
          const double spacingBetween = 40;

          final screenWidth = constraints.maxWidth;
          final remainingSpace = (screenWidth -
                  (videoWidth +
                      rightButtonsWidth +
                      scrollButtonsWidth +
                      spacingBetween * 2)) /
              2;

          return Scaffold(
            backgroundColor: Colors.black,
            drawer: const WebDrawer(), // 💡 1. إضافة الـ Drawer
            body: Builder( // 💡 2. استخدام Builder للحصول على context الـ Scaffold
              builder: (context) {
                return Stack( // 💡 3. استخدام Stack لوضع زر القائمة فوق المحتوى
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

                          // 🎛️ RightButtons
                          SizedBox(
                            width: rightButtonsWidth,
                            child: RightButtons(
                              tripId: _currentTripId,
                              currentTripCategory: _currentTripCategory,
                              personCounterKey: _currentPersonCounterKey, 
                              selectedTripSummary: _tripSummaryText,

                              onHotelSelected: (id, price) { 
                                if (!mounted) return;
                                setState(() { _selectedHotelId = id; _selectedHotelPrice = price; });
                              },
                              onCarSelected: (id, price) { 
                                if (!mounted) return;
                                setState(() { _selectedCarId = id; _selectedCarPrice = price; });
                              },
                              onActivitySelected: (id, price) { 
                                if (!mounted) return;
                                setState(() { _selectedActivityId = id; _selectedActivityPrice = price; });
                              },
                              onFlightSelected: (id, price) {}, 

                              onSummaryReady: _updateTripSummary, 
                              onDateRangeSelected: onDateRangeSelected,
                            ),
                          ),

                          const SizedBox(width: spacingBetween),

                          // ⬆️⬇️ أزرار السحب
                         // داخل _HomePageState في دالة build (في قسم الويب)

// ...
// ⬆️⬇️ أزرار السحب
SizedBox(
    width: scrollButtonsWidth,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
             // زر الصعود (الفيديو السابق)
             Builder(
                builder: (context) {
                    final status = videoPlayerScreenKey.currentState?.getScrollStatus();
                    final currentIndex = status?['currentIndex'] ?? 0;
                    final isFirstVideo = currentIndex == 0;
                    
                    return Tooltip( // 🆕 إضافة Tooltip هنا
                        message: AppLocalizations.of(context)!.previousVideo, // ⬅️ النص الجديد
                        child: IconButton(
                            icon: Icon(Icons.keyboard_arrow_up,
                                size: 40, 
                                color: isFirstVideo ? Colors.white24 : Colors.white70),
                            onPressed: isFirstVideo ? null : _scrollToPreviousPage,
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.white10,
                            ),
                        ),
                    );
                },
            ),
            
            const SizedBox(height: 20),

            // زر النزول (الفيديو التالي)
            Tooltip( // 🆕 إضافة Tooltip هنا
                message: AppLocalizations.of(context)!.nextVideo, // ⬅️ النص الجديد
                child: IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        size: 40, color: Colors.white70),
                    onPressed: _scrollToNextPage,
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.white10,
                    ),
                ),
            ),
        ],
    ),
),
                        ],
                      ),
                    ),

                    // 💡 4. زر القائمة في الزاوية العلوية اليسرى
                    Positioned(
                      top: 20,
                      left: 20,
                      child: IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                        onPressed: () {
                          // استدعاء openDrawer من الـ Scaffold
                          Scaffold.of(context).openDrawer(); 
                        },
                      ),
                    ),
                  ],
                );
              }
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