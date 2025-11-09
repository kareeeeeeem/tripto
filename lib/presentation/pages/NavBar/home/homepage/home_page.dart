// 💡 استورد الملف الجديد
// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tripto/core/CategoryButtonsRow.dart'; 
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/ActivityPage/activities_page.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/AllCars.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/VedioPlayerPage.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/WebDrawer.dart';
import 'package:tripto/presentation/pages/NavBar/home/search/SearchPage.dart';
import 'package:tripto/presentation/pages/NavBar/home/search/DateCardStandalone.dart';
import 'package:tripto/presentation/pages/NavBar/hotel/HotelCard.dart'; 
import 'package:tripto/presentation/pages/SlideBar/RightButtons.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Event.dart'; // 💡 تأكد من استيراد FetchTripsByDate

class FetchTripsByDateRange extends SearchTripByCategoryEvent {
  final DateTime startDate;
  final DateTime endDate;
  const FetchTripsByDateRange({required this.startDate, required this.endDate});
  
  @override
  List<Object> get props => [startDate, endDate];
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<VideoPlayerScreenState> videoPlayerScreenKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _isDrawerOpen = false; 

  int _currentTripId = 1; 
  int _currentTripCategory = 0; 
  GlobalKey<PersonCounterWithPriceState> _currentPersonCounterKey = GlobalKey(); 

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  String? _tripSummaryText;
  int? _selectedHotelId;
  double _selectedHotelPrice = 0.0;
  int? _selectedCarId;
  double _selectedCarPrice = 0.0;
  int? _selectedActivityId;
  double _selectedActivityPrice = 0.0;

  bool _isFullscreen = false;

  
  final TextEditingController _subDestinationController = TextEditingController();
  List? allSubDestinations;
  int? selectedSubDestinationId;


  @override
  void initState() {
    super.initState();
    _fetchSubDestinations(); 

   
  }
void toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }


  Future<void> _fetchSubDestinations() async {
    try {
      final response = await http
          .get(Uri.parse("https://tripto.blueboxpet.com/api/sub-destinations"));
      

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (mounted) {
          setState(() {
            allSubDestinations = data;
          });
        }

      } else {
        debugPrint("Failed to load sub-destinations: ${response.statusCode}");
      }

    } catch (e) {
      debugPrint("Error fetching sub-destinations: $e");
    }
  }


// دالة تنفيذ البحث حسب الفئة (معتمدة على VideoPlayerScreen لإرسال التفاصيل)
 void _executeCategorySearch(int categoryIndex) {
  final videoState = videoPlayerScreenKey.currentState;
  videoState?.pauseCurrentVideo(); 
  videoState?.disposeAllVideos();
  
  // ⭐️ التعديل هنا: إعادة تعيين التاريخ والوجهة الفرعية ⭐️
  _subDestinationController.clear();
  selectedSubDestinationId = null;
  _rangeStart = null;
  _rangeEnd = null;

  // 💡 إذا كانت الفئة -1 (إلغاء التحديد)، قم بطلب إعادة تحميل الفيديو بلاير للحالة الافتراضية
  if (categoryIndex == -1) {
    videoState?.fetchAllTrips(); 
    // يتم تحديث _currentTripId بواسطة الكولباك onTripChanged من VideoPlayerScreen
  } else {
    // 💡 عند البحث بنجاح، يتم تحديث تفاصيل الرحلة من خلال VideoPlayerScreenState.
    setState(() {
      _currentTripCategory = categoryIndex;
      // تحديث مفتاح العداد لضمان إعادة رسمه/تهيئته
      _currentPersonCounterKey = GlobalKey(); 
    });
  }
 }


  // دالة تنفيذ البحث حسب الوجهة الفرعية
void _executeSubDestinationSearch(String destinationName) {
  if (destinationName.isNotEmpty) {
    final videoState = videoPlayerScreenKey.currentState;
    videoState?.pauseCurrentVideo(); 
    videoState?.disposeAllVideos(); 
    
    // إعادة تعيين التاريخ عند البحث بالوجهة الفرعية
    _rangeStart = null;
    _rangeEnd = null;

    context.read<SearchTripBySubDestinationBloc>().add(
        FetchTripsBySubDestination(subDestination: destinationName.trim()));
  }
}

// 🆕 دالة تنفيذ البحث حسب نطاق التاريخ
void _executeDateRangeSearch(DateTime startDate, DateTime endDate) {
  final videoState = videoPlayerScreenKey.currentState;
  videoState?.pauseCurrentVideo();
  videoState?.disposeAllVideos();
  
  // إعادة تعيين الوجهة الفرعية والفئة
  _subDestinationController.clear();
  selectedSubDestinationId = null;
  setState(() { _currentTripCategory = -1; }); 

  // 🚨 استخدام الحدث FetchTripsByDate الذي يعمل لديك في SearchPage
  context.read<SearchTripByDateBloc>().add(
      FetchTripsByDate(from: startDate, to: endDate)); // ✅ تم التعديل
}



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
    // هذه الدالة يتم استدعاؤها من VideoPlayerScreen بعد تحميل كل فيديو جديد
  }

  void _updateTripSummary(String? summary) {
    if (!mounted) return;
    if (summary != _tripSummaryText) {
      setState(() {
        _tripSummaryText = summary;
      });
      debugPrint("✅ Summary received in HomePage: $summary");
      videoPlayerScreenKey.currentState?.updateTripSummaryText(summary); 
    }
  }

  void _toggleFullscreen(bool? isFullscreen) {
    setState(() {
      _isFullscreen = isFullscreen ?? !_isFullscreen;
    });
  }

  void _handleSearchNavigation() async {
    final videoState = videoPlayerScreenKey.currentState;
    
    videoState?.pauseCurrentVideo(); 

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (ctx) => const SearchPage(), 
      ),
    );

    if (result == true) {
      videoState?.disposeAllVideos(); 
      videoState?.fetchAllTrips();    
      // الاعتماد على onTripChanged من VideoPlayerScreen لتحديث الحالة
    }
    videoState?.playCurrentVideo();
  }

// ⭐️ الدالة الموحدة لفتح ديالوج التاريخ المخصص (منقولة من SearchPage) ⭐️
void _showArabicDateRangePicker(BuildContext context) async {
  final result = await showDialog(
    context: context,
    builder: (context) {
      final isWeb = MediaQuery.of(context).size.width > 600; 
      final dialogWidth = isWeb ? 500.0 : double.infinity;   

      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SizedBox(
          width: dialogWidth, 
          height: isWeb ? 500 : null, 
          child: ArabicDateRangePicker(
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          ),
        ),
      );
    },
  );

  if (result != null) {
    final DateTime startDate = result['range_start'];
    final DateTime endDate = result['range_end'];

    // 1. تحديث الحالة في HomePage
    // onDateRangeSelected(startDate, endDate); 
    
    // 2. تنفيذ البحث باستخدام الـ Bloc
    _executeDateRangeSearch(startDate, endDate);
  }
}

// 4. دالة استدعاء ديالوج التاريخ من زر الـ UI
// 🆕 دالة لإظهار منتقي نطاق التاريخ (تستدعي الدالة الموحدة)
  void _selectDateRange() async {
    // ⭐️ استدعاء الدالة الموحدة بدلاً من showDateRangePicker ⭐️
    _showArabicDateRangePicker(context);
  }


  void onDateRangeSelected(DateTime? start, DateTime? end) {
    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
    });
    debugPrint("📅 Date Range Updated -> From: $start, To: $end");
  }

  void _scrollToNextPage() {
    videoPlayerScreenKey.currentState?.nextPage();
  }


  void _scrollToPreviousPage() {
    videoPlayerScreenKey.currentState?.previousPage();
  }

  // مكون بناء لزر الوجهة الفرعية (Sub-Destination Button)
  Widget _buildSubDestinationChip(Map subDestination, bool isArabic) {
    final name = isArabic ? subDestination['name_ar'] : subDestination['name_en'];
    final id = subDestination['id'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ActionChip(
        label: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        onPressed: () {
          
          _subDestinationController.text = name; 
          selectedSubDestinationId = id;          
          _executeSubDestinationSearch(name);     
        },
       backgroundColor: Colors.grey.shade600, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
    );
  }

  // 🆕 مكون بناء شريط البحث والـ Chips
  Widget _buildSearchBarAndChips(BuildContext context, bool isArabic) {
      
      // زر البحث بالتاريخ (الجديد)
      final dateSearchButton = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white10,
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: IconButton(
            icon: const Icon(Icons.calendar_month, size: 20, color: Colors.white70),
            onPressed: _selectDateRange, 
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(
              minimumSize: Size.zero, 
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      );
      
      // 🚨 الاستخدام الصحيح لـ CategoryButtonsRow كودجت
      // الـ CategoryButtonsRow
      final categoryButtons = CategoryButtonsRow(
        onCategorySearch: _executeCategorySearch,
      );
      
      // شريط البحث (TypeAheadField)
      final searchBar = Expanded(
        child: TypeAheadField(
          controller: _subDestinationController,
          focusNode: FocusNode(),
          showOnFocus: true,
          suggestionsCallback: (pattern) async {
            if (allSubDestinations == null) return [];
            if (pattern.isEmpty) return allSubDestinations!;
            return (allSubDestinations!).where((sub) {
              final name = isArabic ? sub['name_ar'] : sub['name_en'];
              return name.toLowerCase().contains(pattern.toLowerCase());
            }).toList();
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(isArabic ? suggestion['name_ar'] : suggestion['name_en'], style: const TextStyle(color: Colors.black)),
            );
          },
          onSelected: (suggestion) {
            _subDestinationController.text = isArabic ? suggestion['name_ar'] : suggestion['name_en'];
            selectedSubDestinationId = suggestion['id'];
            _executeSubDestinationSearch(_subDestinationController.text);
          },
          builder: (context, controller, focusNode) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              onSubmitted: (value) { 
                _executeSubDestinationSearch(value);
                focusNode.unfocus(); 
              },
              style: const TextStyle(color: Colors.white), 
              decoration: InputDecoration(
                hintText: isArabic ? "ابحث عن وجهة فرعية..." : "Search for sub-destination...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white10, 
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    _executeSubDestinationSearch(_subDestinationController.text);
                    focusNode.unfocus(); 
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              ),
            );
          },
        ),
      );
      
      final children = <Widget>[];
      if (isArabic) {
        // RTL: زر التاريخ، أزرار الفئات، شريط البحث
        children.addAll([
          dateSearchButton,
          categoryButtons,
          const SizedBox(width: 15),
          searchBar,
        ]);
      } else {
        // LTR: شريط البحث، زر التاريخ، أزرار الفئات
        children.addAll([
          searchBar,
          const SizedBox(width: 15),
          dateSearchButton,
          categoryButtons,
        ]);
      }


      return Container(
        color: Colors.black.withOpacity(0.6), 
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Center(child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900 ), 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children, // 💡 استخدام القائمة المرتبة
                ),
              ),
            )),
            
            const SizedBox(height: 10),

            // شريط الوجهات الفرعية القابل للتمرير
            if (allSubDestinations != null)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: (allSubDestinations as List).map<Widget>((sub) {
                    return _buildSubDestinationChip(sub, isArabic);
                  }).toList(),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 20, 
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white70, strokeWidth: 2), 
                ),
              ), 
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return LayoutBuilder(
      builder: (context, constraints) {
        const double webBreakpoint = 1200;   
        
        
          // شاشات كبيرة (كمبيوتر / لابتوب)
        const double tabletBreakpoint = 1000;   // التابلت أو الآيباد
        const double mobileBreakpoint = 480;   // الموبايل


          final bool isWebLayout = constraints.maxWidth >= webBreakpoint;
          final bool isTabletLayout = constraints.maxWidth >= 1000 && constraints.maxWidth < webBreakpoint;
          final bool isMobileLayout = constraints.maxWidth < 1000;

         if (kIsWeb) { 
  
           const double videoWidth = 450;
          //const double rightButtonsWidth = 520;
         // const double spacingBetween = 80;
          const double searchBarHeightPadding = 130.0; 
          const double searchBarbottomPadding = 55.0; 

          const double rightEdgePadding = 40.0; 
          const double totalFixedWidth = videoWidth + 20 + 450;
          
          
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.black, 
            drawerScrimColor: Colors.transparent,
            drawerEnableOpenDragGesture: false,
            endDrawerEnableOpenDragGesture: false,
            body: Builder( 
              builder: (context) {

                if (_isFullscreen) {
                  return Stack(
                    children: [
                     Positioned.fill(
                        child: VideoPlayerScreen(
                          key: videoPlayerScreenKey,
                          onTripChanged: _updateCurrentTripDetails,
                          onSearchPressed: _handleSearchNavigation,
                          onToggleFullscreen: _toggleFullscreen,
                          isCurrentlyFullscreen: _isFullscreen, // مهم لإخبار الودجت بأنه في وضع ملء الشاشة
                        ),
                      ),
                      
                    // زر الخروج من ملء الشاشة
                      Positioned(
                        top: 20,
                        right: 20,
                        child: IconButton(
                          icon: const Icon(Icons.fullscreen_exit_rounded, color: Colors.white, size: 40),
                          onPressed: () => _toggleFullscreen(false),
                         style: IconButton.styleFrom(
                                          backgroundColor: Colors.white10,
                                          padding: const EdgeInsets.all(12),
                                        ),
                        ),
                      ),
              
                    ],
                  );
                }
                
                final screenWidth = constraints.maxWidth;               
                
                return Stack( 
                  children: [
                    // شريط البحث والـ Chips (يبقى في الأعلى)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: _buildSearchBarAndChips(context, isArabic), 
                    ),
 
                    Padding(
                      padding: EdgeInsets.only(top: searchBarHeightPadding, bottom: searchBarbottomPadding), 
                      

                      // 💡 التعديل الرئيسي: استخدام تخطيط مختلف بناءً على حجم الشاشة
    child: constraints.maxWidth >= webBreakpoint
      ? Padding(
        padding:  EdgeInsets.only(

          left: !isArabic ? 400.0 : 0.0,
          right: isArabic ? 400.0 : 0.0,
          ),
         child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: videoWidth,
                  maxHeight: constraints.maxHeight - searchBarHeightPadding - 30, 
                ),
                child: VideoPlayerScreen(
                  key: videoPlayerScreenKey,
                  onTripChanged: _updateCurrentTripDetails,
                  onSearchPressed: _handleSearchNavigation, 
                  onToggleFullscreen: _toggleFullscreen, 
                  isCurrentlyFullscreen: _isFullscreen,
                ),
              ),
              const SizedBox(width: 20),
              // 🎛️ RightButtons تظهر خارج الفيديو على الويب فقط
              if (constraints.maxWidth >= webBreakpoint)
                Positioned(
                  top: 130,
                  right: 20,
                  bottom: 55,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 330,
                        maxWidth: 400,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
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
                    ),
                  ),
                ),
            ],
          ),
        ),
      )
    : Center(
        // 💡 للشاشات الأصغر (تابلت أو موبايل): RightButtons داخل الفيديو
        child: Stack(
          alignment: Alignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * 0.8,
                maxHeight: constraints.maxHeight - searchBarHeightPadding - 30,
              ),
              child: VideoPlayerScreen(
                key: videoPlayerScreenKey,
                onTripChanged: _updateCurrentTripDetails,
                onSearchPressed: _handleSearchNavigation,
                onToggleFullscreen: _toggleFullscreen,
                isCurrentlyFullscreen: _isFullscreen,
              ),
            ),
            Positioned(
              
              
             right: isArabic ? null : 2, // في الإنجليزي (LTR) تبقى 2 من اليمين
             left: isArabic ? 2 : null,  // في العربي (RTL) تصبح 2 من اليسار
              top: 50,
              bottom: 0,
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                color: Colors.transparent, 
                ),
                padding: const EdgeInsets.all(10),
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
            ),
          ],
        ),
      ),
 ) ,

















        // أزرار السكرول في أقصى اليمين (تبقى في الويب فقط)
      if (constraints.maxWidth >= webBreakpoint) 
               // أزرار السكرول في أقصى اليمين (الوضع العادي)
                    Positioned(
                      left: isArabic ? rightEdgePadding : null, // في العربي تظهر على اليسار
                      right: isArabic ? null : rightEdgePadding, // في الإنجليزي تظهر على اليمين
                      top: 0,
                      bottom: 0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                               Builder(
                                  builder: (context) {
                                      final status = videoPlayerScreenKey.currentState?.getScrollStatus();
                                      final currentIndex = status?['currentIndex'] ?? 0;
                                      final isFirstVideo = currentIndex == 0;
                                      
                                      return Tooltip( 
                                          message: loc.previousVideo, 
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
                            
                              Tooltip( 
                                  message: loc.nextVideo, 
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


                  // 🟢 التعديل 1: يظهر الدرج عندما يكون مفتوحاً (_isDrawerOpen = true)
                  if (_isDrawerOpen &&  constraints.maxWidth >= webBreakpoint) 
                  Positioned(
                    top: 70,
                    left: isArabic ? null : 20,
                    right: isArabic ? 20 : null,
                    bottom: 0,
                    child: SizedBox(width: 300, child: const WebDrawer()),
                  ),

                // 🟢 التعديل 2: تظهر الأيقونات عندما يكون الدرج مغلقاً (_isDrawerOpen = false)
        if (!_isDrawerOpen && constraints.maxWidth > 1000) 
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
        if (constraints.maxWidth > 1000) 

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
                      

                              if (constraints.maxWidth > 1200) 

                      Image.asset(
                        'assets/images/TRIPTO.png',
                        height: 58,
                        width: 75,
                      ),
                    ],
                  ),
                ),
                  ],
                );
              },
            ),
            );
          
        } else {
          // 📱 للموبايل (خارج وضع الويب)
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