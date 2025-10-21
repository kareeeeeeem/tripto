import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/VedioPlayerPage.dart';
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

  // داخل _HomePageState

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
    // تحديث بيانات الرحلة الأساسية
    _currentTripId = tripId;
    _currentTripCategory = category;
    _currentPersonCounterKey = personCounterKey;
    _tripSummaryText = tripSummary;

    // 🚀 تحديث بيانات الخدمات المُختارة
    _selectedHotelId = hotelId;
    _selectedHotelPrice = hotelPrice;
    _selectedCarId = carId;
    _selectedCarPrice = carPrice;
    _selectedActivityId = activityId;
    _selectedActivityPrice = activityPrice;
  });
}

// ✨ التعديل هنا: جعل الـ summary قابلاً للقيمة الفارغة (String?)
void _updateTripSummary(String? summary) {
    if (!mounted) return;
    // المقارنة والتحديث ستكون صحيحة لأن _tripSummaryText هو أيضاً String?
    if (summary != _tripSummaryText) {
      setState(() {
        _tripSummaryText = summary;
      });
      debugPrint("✅ Summary received in HomePage: $summary");
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
    // التأكد من أن nextPage موجودة قبل الاستدعاء
    if (state != null && (state as dynamic).nextPage is Function) {
      (state as dynamic).nextPage();
    }
  }

  void _scrollToPreviousPage() {
    final state = videoPlayerScreenKey.currentState;
    // التأكد من أن previousPage موجودة قبل الاستدعاء
    if (state != null && (state as dynamic).previousPage is Function) {
      (state as dynamic).previousPage();
    }
  }

  // 🔥 إضافة عنصر Drawer القائمة الجانبية
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white, // خلفية داكنة
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, // لون أساسي جذاب
            ),
            child: const Text(
              'Trip To',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white70),
            title: const Text('الرئيسية', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // إغلاق القائمة
              // إضافة إجراء الذهاب للصفحة
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.white70),
            title: const Text('المفضلة', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              // إضافة إجراء الذهاب للمفضلة
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white70),
            title: const Text('الإعدادات', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              // إضافة إجراء الذهاب للإعدادات
            },
          ),
          // يمكنك إضافة المزيد من العناصر هنا...
        ],
      ),
    );
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
          const double spacingBetween = 5;

          final screenWidth = constraints.maxWidth;
          final remainingSpace = (screenWidth -
                  (videoWidth +
                      rightButtonsWidth +
                      scrollButtonsWidth +
                      spacingBetween * 2)) /
              2;

          return Scaffold(
            backgroundColor: Colors.black,
            // 💡 في الويب/التابلت (الشاشة الكبيرة)، القائمة الجانبية غير منطقية، لذا نستخدم Scaffold عادي
            body: Center(
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

                  // 🎛️ RightButtons (نفسها بالضبط زي VideoPlayerPage)
                  SizedBox(
                    width: rightButtonsWidth,
                    child: RightButtons(
                      tripId: _currentTripId,
                      currentTripCategory: _currentTripCategory,
                      // تم التأكد من أن _currentPersonCounterKey من النوع الصحيح في البداية
                      personCounterKey: _currentPersonCounterKey, 
                      selectedTripSummary: _tripSummaryText,

                      // 🚀 تمرير المعرفات والأسعار المُحدثة من حالة HomePage
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
                      onFlightSelected: (id, price) {}, // يجب تحديث هذه أيضاً إذا كانت تؤثر على السعر الإجمالي

                      onSummaryReady: _updateTripSummary, // الآن التوقيع متوافق مع String?
                      onDateRangeSelected: onDateRangeSelected,
                    ),
                  ),

                  const SizedBox(width: spacingBetween),

                  // ⬆️⬇️ أزرار السحب
                  SizedBox(
                    width: scrollButtonsWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_up,
                              size: 40, color: Colors.white70),
                          onPressed: _scrollToPreviousPage,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white10,
                          ),
                        ),
                        const SizedBox(height: 20),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down,
                              size: 40, color: Colors.white70),
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
          );
        } else {
          // 📱 للموبايل (وضع الشاشة الصغيرة)
          return Scaffold(
            backgroundColor: Colors.black,
            // 💡 إضافة الـ Drawer (القائمة الجانبية)
            drawer: _buildSideDrawer(context),
            // 💡 إضافة الـ AppBar لكي يظهر زر القائمة التلقائي في اليسار
            appBar: AppBar(
              backgroundColor: Colors.transparent, // لجعل الـ AppBar شفافاً فوق الفيديو
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white), // لون أيقونة القائمة
              // يمكنك إضافة عنوان أو عناصر أخرى يمين الـ AppBar هنا
              title: const Text(
                'Trip To', 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: const VideoPlayerScreen(),
          );
        }
      },
    );
  }
}
