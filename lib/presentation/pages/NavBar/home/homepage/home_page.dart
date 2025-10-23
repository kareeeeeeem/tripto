import 'dart:math' as math; 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/VedioPlayerPage.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/WebDrawer.dart';
import 'package:tripto/presentation/pages/NavBar/home/search/SearchPage.dart';
import 'package:tripto/presentation/pages/SlideBar/RightButtons.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Event.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<VideoPlayerScreenState> videoPlayerScreenKey = GlobalKey();

  // 🗑️ تم دمج المتغيرات المتكررة وإبقائها كالتالي
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

    // 💡 تم نقل منطق فتح الـ Drawer إلى هنا لـ initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 0));
      if (mounted && kIsWeb) {
        _scaffoldKey.currentState?.openDrawer();
      }
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

  // 💡 دالة تنفيذ البحث حسب الوجهة الفرعية
void _executeSubDestinationSearch(String destinationName) {
  if (destinationName.isNotEmpty) {
    // 1. إيقاف وإلغاء تهيئة الفيديوهات القديمة
    final videoState = videoPlayerScreenKey.currentState;
    videoState?.pauseCurrentVideo(); 
    videoState?.disposeAllVideos(); 
    
    // 2. إرسال حدث البحث إلى البلوك.
    context.read<SearchTripBySubDestinationBloc>().add(
        FetchTripsBySubDestination(subDestination: destinationName.trim()));
  }
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
    }
    videoState?.playCurrentVideo();
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

  // 🆕 مكون بناء لزر الوجهة الفرعية (Sub-Destination Button)
  Widget _buildSubDestinationChip(Map subDestination, bool isArabic) {
    final name = isArabic ? subDestination['name_ar'] : subDestination['name_en'];
    final id = subDestination['id'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ActionChip(
        label: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        onPressed: () {
          
          _subDestinationController.text = name; // 1. ملء شريط البحث
          selectedSubDestinationId = id;          // 2. تعيين الـ ID
          _executeSubDestinationSearch(name);     // 3. تنفيذ البحث
        },
       backgroundColor: Colors.grey.shade600, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
    );
  }

  // 🆕 مكون بناء شريط البحث والـ Chips (يُستخدم في وضع ملء الشاشة والوضع العادي)
  Widget _buildSearchBarAndChips(BuildContext context, bool isArabic) {
      return Container(
        color: Colors.black.withOpacity(0.6), 
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔍 شريط البحث
            Center(child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 750 ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    // 💡 تفعيل البحث عند الاختيار من القائمة
                    _executeSubDestinationSearch(_subDestinationController.text);
                  },
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      // 💡 الخاصية الجديدة: تشغيل البحث عند الضغط على Enter
                      onSubmitted: (value) { 
                        _executeSubDestinationSearch(value);
                        // إخفاء لوحة المفاتيح بعد البحث
                        focusNode.unfocus(); 
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: isArabic ? "ابحث عن وجهة فرعية..." : "Search for sub-destination...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        // 💡 تعديل أيقونة البحث لجعلها قابلة للضغط
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            // 💡 تفعيل البحث عند الضغط على الأيقونة
                            _executeSubDestinationSearch(_subDestinationController.text);
                            focusNode.unfocus(); // إخفاء لوحة المفاتيح
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder( // 💡 يجب تطبيق نفس الـ borderRadius على الـ enabledBorder أيضاً
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                    );
                  },
                ),
              ),
            )),
            
            const SizedBox(height: 10),

            // ➡️ شريط الوجهات الفرعية القابل للتمرير
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
        const double tabletBreakpoint = 600;

        if (constraints.maxWidth > tabletBreakpoint && kIsWeb) {
          const double videoWidth = 450;
          const double rightButtonsWidth = 520;
          const double scrollButtonsWidth = 100; // تم الإبقاء عليها كتعريف
          const double spacingBetween = 80;
          const double searchBarHeightPadding = 130.0; 
          
          // 💡 المسافة من الحافة اليمنى لأزرار السكرول في الوضع العادي و ملء الشاشة
          const double rightEdgePadding = 40.0; 
          
          // 💡 إعادة حساب totalFixedWidth بدون أزرار السكرول ومسافتها الفاصلة الأخيرة
          const double totalFixedWidth = videoWidth + rightButtonsWidth + spacingBetween; 

          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.black,
            drawer: const WebDrawer(), 
            drawerScrimColor: Colors.transparent,

            body: Builder( 
              builder: (context) {

                if (_isFullscreen) {
                  return Stack(
                    children: [
                      VideoPlayerScreen(
                        key: videoPlayerScreenKey,
                        onTripChanged: _updateCurrentTripDetails,
                        onSearchPressed: _handleSearchNavigation, 
                        onToggleFullscreen: _toggleFullscreen, 
                      ),
                      
                      // 🗑️ تم إخفاء شريط البحث والـ Chips من هنا

                      // 💡 زر الخروج من ملء الشاشة
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
                      
                      // 💡 أزرار السكرول في أقصى اليمين (وضع ملء الشاشة)
                      Positioned(
                        right: rightEdgePadding, 
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
                                  
                                  const SizedBox(height: 20),

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
                    ],
                  );
                }

                
                final screenWidth = constraints.maxWidth;
                
                final remainingSpace = math.max(
                    0.0,
                    (screenWidth - totalFixedWidth) / 2,
                );

                return Stack( 
                  children: [
                    
                    // 💡 شريط البحث والـ Chips (الوضع العادي)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: _buildSearchBarAndChips(context, isArabic), 
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: searchBarHeightPadding), 
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: remainingSpace), // المسافة اليسرى المتغيرة
                            
                            // 🎬 الفيديو
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: videoWidth,
                                maxHeight: 950 - searchBarHeightPadding, 
                              ),
                              child: VideoPlayerScreen(
                                key: videoPlayerScreenKey,
                                onTripChanged: _updateCurrentTripDetails,
                                onSearchPressed: _handleSearchNavigation, 
                                onToggleFullscreen: _toggleFullscreen, 
                                ),
                            ),

                            const SizedBox(width: spacingBetween), // المسافة بين الفيديو و RightButtons

                            // 🎛️ RightButtons
                            ConstrainedBox( 
                              constraints: const BoxConstraints(
                                maxWidth: rightButtonsWidth,
                                maxHeight: 850 - searchBarHeightPadding, 
                              ),
                             child: Column(
                                children: [
                                  Expanded(
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
                                ],
                              ),
                            ),
                            
                            // 🗑️ تم حذف مسافة spacingBetween وأزرار السكرول من هنا
                          ],
                        ),
                      ),
                    ),
                    
                    // 💡 زرار القائمة
                    Positioned(
                      top: 40, 
                      left: 20,
                      child: IconButton(
                        icon: const Icon(Icons.menu_outlined, color: Colors.white, size: 30),
                        onPressed: () {
                          Scaffold.of(context).openDrawer(); 
                        },style: IconButton.styleFrom(
                                          backgroundColor: Colors.white10,
                                          padding: const EdgeInsets.all(12),
                                        ),
                      ),
                    ),
                    
                    // 💡 أزرار السكرول في أقصى اليمين (الوضع العادي)
                    Positioned(
                      right: rightEdgePadding, 
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
                              
                              const SizedBox(height: 20),

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
                  ],
                );
              },
            ),
          );
        } else {
          // 📱 للموبايل 
          return const Scaffold(
            backgroundColor: Colors.black,
            body: VideoPlayerScreen(),
          );
        }
      },
    );
  }
}