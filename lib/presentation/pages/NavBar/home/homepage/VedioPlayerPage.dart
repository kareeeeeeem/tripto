import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:tripto/bloc&repo/BookNow_OrderTrip/OrderTripBloc.dart';
import 'package:tripto/bloc&repo/BookNow_OrderTrip/OrderTripEvent.dart';
import 'package:tripto/bloc&repo/BookNow_OrderTrip/OrderTripState.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_event.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_repository.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_State.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_State.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_State.dart';
import 'package:tripto/presentation/pages/NavBar/home/search/SearchPage.dart';
import 'package:tripto/presentation/pages/NavBar/profile_logiin_sign_verfi/profile_page.dart';
import 'package:tripto/presentation/pages/SlideBar/RightButtons.dart';
import 'package:tripto/presentation/pages/screens/leftSide/CountryWithCity.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/core/constants/CustomButton.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/main.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

typedef TripDetailsCallback = void Function(
  int tripId,
  int category,
  GlobalKey<PersonCounterWithPriceState> personCounterKey,
  String? tripSummary, 
  int? selectedHotelId,
  double selectedHotelPrice,
  int? selectedCarId,
  double selectedCarPrice,
  int? selectedActivityId,
  double selectedActivityPrice,
);

typedef SearchCallback = void Function();

typedef ToggleFullscreenCallback= void Function(bool? isFullscreen);

class VideoPlayerScreen extends StatefulWidget {
  final TripDetailsCallback? onTripChanged;
  final SearchCallback? onSearchPressed; 
    final ToggleFullscreenCallback? onToggleFullscreen; 

    final bool? isCurrentlyFullscreen; // 🆕 الخاصية الجديدة
    

  

  const VideoPlayerScreen({super.key, 
    this.onTripChanged, 
    this.onSearchPressed, this.onToggleFullscreen, this.isCurrentlyFullscreen=false});

  @override
  State<VideoPlayerScreen> createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen>
    with WidgetsBindingObserver, RouteAware {

  Future<void> _refresh() async {
  // هنا تحط اللوجيك بتاع جلب كل الرحلات من الـ API
  print("🔄 Refreshing all trips...");
  await Future.delayed(const Duration(seconds: 2));
  }

  final _storage = const FlutterSecureStorage();
  final _scrollController = PageController();
  final double _bookingPricePerPerson = 0.0;

  List<GlobalKey<PersonCounterWithPriceState>> _personCounterKeys = [];
  List<Map<String, dynamic>> _allTrips = [];
  List<Map<String, dynamic>> _trips = [];
  int _currentIndex = 0;
  bool _isMuted = false;

  final Map<int, VideoPlayerController> _videoControllers = {};
  final Map<int, ChewieController> _chewieControllers = {};
  final Map<int, bool> _videoErrorState = {};

  bool _isLoadingFirstPage = true;
  String _initialErrorMessage = '';
  int _currentPage = 0;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  final int _perPage = 5;

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  int? selectedFlyId;
  double selectedFlightPrice = 0.0;
  bool? _hasFly;
  int? selectedHotelId;
  double selectedHotelPrice = 0.0;
  int? selectedCarId;
  double selectedCarPrice = 0.0;
  int? selectedActivityId;
  double selectedActivityPrice = 0.0;  
  // 👥 Person Counter (عشان عدد الأشخاص + السعر)
  final GlobalKey<PersonCounterWithPriceState> personCounterKey =
      GlobalKey<PersonCounterWithPriceState>();

  String? _tripSummaryText; // 🌟 متغير لحفظ النص

  





// 🆕 دالة جديدة للتعامل مع فتح صفحة البحث (تُستخدم في الويب)
void _handleSearchNavigation() async {
  final videoState = videoPlayerScreenKey.currentState;
  
  // 1. إيقاف الفيديو الحالي مؤقتاً
  videoState?.pauseCurrentVideo(); 

  // 2. الانتقال لصفحة البحث
  final result = await Navigator.push<bool>(
    context,
    MaterialPageRoute(
      builder: (ctx) => const SearchPage(), // تأكد من استيراد SearchPage
    ),
  );

  // 3. عند العودة:
  if (result == true) {
    // إذا كان هناك تحديث للرحلات بعد البحث
    videoState?.disposeAllVideos(); // (إذا كانت هذه الدالة موجودة وتعمل)
    videoState?.fetchAllTrips();    // (إذا كانت هذه الدالة موجودة وتعمل)
  }
  
  // 4. إعادة تشغيل الفيديو
  videoState?.playCurrentVideo();
}

  //عرض الملخص فالهوم
  void updateTripSummaryText(String? newSummary) {
    if (mounted && newSummary != _tripSummaryText) {
      setState(() {
        _tripSummaryText = newSummary;
      });
      debugPrint("✅ VideoPlayerScreen: Summary updated locally to: $_tripSummaryText");
    }
  }
Map<String, int> getScrollStatus() {
  return {
    'currentIndex': _currentIndex,
    'totalTrips': _trips.length,
  };
}
      
 // 🆕 ضع الدوال هنا
    void onDateRangeSelected(DateTime? start, DateTime? end) {
      setState(() {
        _rangeStart = start;
        _rangeEnd = end;
      });
      print("✅ VideoPlayerScreen: Date Range Updated -> From: $start, To: $end");
    }
    
    void updateSelectedHotel(int? id, double price) {
      setState(() {
        selectedHotelId = id;
        selectedHotelPrice = price;
      });
      print("✅ VideoPlayerScreen: Hotel Updated -> ID: $id, Price: $price");
    }

    void updateSelectedCar(int? id, double price) {
      setState(() {
        selectedCarId = id;
        selectedCarPrice = price;
      });
      print("✅ VideoPlayerScreen: Car Updated -> ID: $id, Price: $price");
    }

    void updateSelectedActivity(int? id, double price) {
      setState(() {
        selectedActivityId = id;
        selectedActivityPrice = price;
      });
      print("✅ VideoPlayerScreen: Activity Updated -> ID: $id, Price: $price");
    }

    void updateSelectedFlight(int? id, double price) {
      setState(() {
        selectedFlyId = id;
        selectedFlightPrice = price;
      });
      print("✅ VideoPlayerScreen: Flight Updated -> ID: $id, Price: $price");
    }
     void nextPage() {
    _scrollController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // 3. الدالة المطلوبة لزر الصعود (الفيديو السابق)
  void previousPage() {
    if(_currentIndex>0){
    _scrollController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }}
    


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchAllTrips();

    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final chewieController = _chewieControllers[_currentIndex];
    if (chewieController == null ||
        !chewieController.videoPlayerController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      chewieController.pause();
    } else if (state == AppLifecycleState.resumed) {
      chewieController.play();
    }
  }

  Future<void> fetchAllTrips() async {
    setState(() {
      _isLoadingFirstPage = true;
      _initialErrorMessage = '';
    });

    try {
      final allTripsData = await TripRepository().fetchTrips();
      if (!mounted) return;

      if (allTripsData.isEmpty) {
        setState(() {
        _initialErrorMessage = AppLocalizations.of(context)!.noTrips;
          _isLoadingFirstPage = false;
        });
        return;
      }

      final allTrips =
          allTripsData.map((trip) => trip.toVideoPlayerJson()).toList();

      setState(() {
        _allTrips = allTrips;
        _trips = _allTrips.take(_perPage).toList();
        _personCounterKeys = List.generate(
          _trips.length,
          (index) => GlobalKey<PersonCounterWithPriceState>(),
        );
        _isLoadingFirstPage = false;
        _hasMoreData = _allTrips.length > _perPage;
      });

      _initializeAndPreloadVideo(0, autoPlay: true);
      if (_trips.length > 1) {
        _initializeAndPreloadVideo(1);
      }
    } catch (e) {
      if (!mounted) return;
      debugPrint('Error fetching all trips: $e');
      setState(() {
        _isLoadingFirstPage = false;
        _initialErrorMessage = 'Failed to load trips. Please try again.';
      });
    }
  }

  Future<void> _fetchMoreTrips() async {
    if (_isLoadingMore || !_hasMoreData) return;

    setState(() => _isLoadingMore = true);
    _currentPage++;

    final startIndex = _currentPage * _perPage;
    if (startIndex >= _allTrips.length) {
      setState(() {
        _hasMoreData = false;
        _isLoadingMore = false;
      });
      return;
    }

    final newTrips = _allTrips.skip(startIndex).take(_perPage).toList();

    setState(() {
      _trips.addAll(newTrips);
      _personCounterKeys.addAll(
        List.generate(
          newTrips.length,
          (index) => GlobalKey<PersonCounterWithPriceState>(),
        ),
      );
      _isLoadingMore = false;
      _hasMoreData = startIndex + _perPage < _allTrips.length;
    });
  }
// 💡 هذه هي الدالة التي تحتاج إلى تعديل
Future<void> _initializeAndPreloadVideo(
    int index, {
    bool autoPlay = false,
  }) async {
    if (_videoControllers.containsKey(index) || index >= _trips.length) return;

    final videoRelativeUrl = _trips[index]['video_url']?.toString() ?? '';
    if (videoRelativeUrl.isEmpty) {
      if (mounted) setState(() => _videoErrorState[index] = true);
      return;
    }

    // 💡 الرابط الأساسي للسيرفر
    const String _baseUrl = "https://tripto.blueboxpet.com/"; 

    // 1. إضافة الرابط الأساسي أولاً
    String fullVideoUrl = _baseUrl + videoRelativeUrl;

    // 2. 🌟 تطبيق نفس منطق تعديل المسار الذي نجح مع الصور 🌟
    // تحويل الرابط من: https://.../storage/videos/...
    // إلى: https://.../storage/app/public/videos/...
    if (fullVideoUrl.contains('/storage/')) {
        fullVideoUrl = fullVideoUrl.replaceFirst("/storage/", "/storage/app/public/");
    }

    // يمكنك طباعة الرابط النهائي للتأكد
    debugPrint("Final Internal Video URL: $fullVideoUrl");

    try {
      // 🎥 استخدام الرابط المعدل لتشغيل الفيديو
      final controller = VideoPlayerController.networkUrl(Uri.parse(fullVideoUrl));

      _videoControllers[index] = controller;
      await controller.initialize();

      final chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: autoPlay,
        looping: true,
        showControls: false,
        allowFullScreen: false,
      );

      if (mounted) {
        setState(() {
          _chewieControllers[index] = chewieController;
          _videoErrorState[index] = false;
        });
      }
    } catch (e) {
      debugPrint("Error initializing video at index $index: $e");
      if (mounted) setState(() => _videoErrorState[index] = true);
    }
  }
  void _onPageChanged(int index) {
    if (_chewieControllers.containsKey(_currentIndex)) {
      _chewieControllers[_currentIndex]?.pause();
    }

    final currentChewieController = _chewieControllers[index];
    if (currentChewieController != null) {
      currentChewieController.play();
      currentChewieController.setVolume(_isMuted ? 0.0 : 1.0);
    } else {
      _initializeAndPreloadVideo(index, autoPlay: true);
    }

    setState(() => _currentIndex = index);

    final currentTrip = _trips[index];
    final int tripId = currentTrip['id'];
    final int category = currentTrip['category'] ?? -1;
    final GlobalKey<PersonCounterWithPriceState> personKey = _personCounterKeys[index];

    if (widget.onTripChanged != null) {
      // ⚠️ ملاحظة: _tripSummaryText قد لا يكون مُحدّثاً تماماً في هذه اللحظة،
      // لكن يمكننا إرساله أو تركه وتحديثه عبر الـ callback الأخرى.
      widget.onTripChanged!(
        tripId,
        category,
        personKey,
        _tripSummaryText,
        selectedHotelId,
        selectedHotelPrice,
        selectedCarId,
        selectedCarPrice,
        selectedActivityId,
        selectedActivityPrice,
      );
    }

    context.read<TripBloc>().add(ChangeCurrentTripEvent(index));

    _disposeDistantVideos(index);

    if (index + 1 < _trips.length) {
      _initializeAndPreloadVideo(index + 1);
    }
    if (index - 1 >= 0) {
      _initializeAndPreloadVideo(index - 1);
    }

    if (index >= _trips.length - 2 && !_isLoadingMore && _hasMoreData) {
      _fetchMoreTrips();
    }
  }

  void _disposeDistantVideos(int currentIndex) {
    final indexesToKeep = [currentIndex, currentIndex - 1, currentIndex + 1];
    _videoControllers.keys
        .where((key) => !indexesToKeep.contains(key))
        .toList()
        .forEach((key) {
      _videoControllers[key]?.dispose();
      _chewieControllers[key]?.dispose();
      _videoControllers.remove(key);
      _chewieControllers.remove(key);
      _videoErrorState.remove(key);
      debugPrint("Disposed video at index $key");
    });
  }

  bool _isDriveUrl(String url) => url.contains('drive.google.com');

  String? _extractDriveId(String url) {
    final regExp1 = RegExp(r'file/d/([a-zA-Z0-9_-]+)');
    final regExp2 = RegExp(r'id=([a-zA-Z0-9_-]+)');
    if (regExp1.hasMatch(url)) return regExp1.firstMatch(url)?.group(1);
    if (regExp2.hasMatch(url)) return regExp2.firstMatch(url)?.group(1);
    return null;
  }

  Future<String> _getDirectDriveLink(String driveUrl) async {
    final videoId = _extractDriveId(driveUrl);
    return videoId != null
        ? 'https://drive.google.com/uc?export=download&id=$videoId'
        : driveUrl;
  }

  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
    _chewieControllers.forEach((_, controller) {
      controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _enterFullscreen(){

        widget.onToggleFullscreen?.call(true);

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);

    _scrollController.dispose();
    _videoControllers.forEach((_, controller) => controller.dispose());
    _chewieControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  void didPushNext() {
    _chewieControllers[_currentIndex]?.pause();
    debugPrint("Navigated away from VideoPlayerScreen, pausing video.");
  }

  @override
  void didPopNext() {
    _chewieControllers[_currentIndex]?.play();
    debugPrint("Returned to VideoPlayerScreen, playing video.");
  }

  void pauseCurrentVideo() {
    _chewieControllers[_currentIndex]?.pause();
  }

  void playCurrentVideo() {
    _chewieControllers[_currentIndex]?.play();
  }

  void disposeAllVideos() {
    _videoControllers.forEach((_, c) => c.dispose());
    _chewieControllers.forEach((_, c) => c.dispose());
    _videoControllers.clear();
    _chewieControllers.clear();
    _videoErrorState.clear();
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (_isLoadingFirstPage) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Color(0xFF002E70)),
              const SizedBox(height: 20),
              Text(
                  AppLocalizations.of(context)!.loadingTrips,

                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    if (_trips.isEmpty && _initialErrorMessage.isNotEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off, color: Colors.white, size: 50),
              const SizedBox(height: 20),
              Text(
                _initialErrorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),


              const SizedBox(height: 20),



// ...

ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.lightBlue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  onPressed: () {
    if (kIsWeb) {
      // 🔹 فقط في الويب: عمل Refresh للصفحة
      html.window.location.reload();
    } else {
      // 🔹 في الموبايل: الحل الحالي
      setState(() {
        _trips = _allTrips.take(_perPage).toList();
        _personCounterKeys = List.generate(
          _trips.length,
          (index) => GlobalKey<PersonCounterWithPriceState>(),
        );
        _currentPage = 0;
        _currentIndex = 0;
        _initialErrorMessage = "";
        _hasMoreData = _allTrips.length > _perPage;
      });
      if (_trips.isNotEmpty) {
        _initializeAndPreloadVideo(0, autoPlay: true);
      }
    }
  },
  child: Text(
    AppLocalizations.of(context)!.backToAllTrips,
    style: const TextStyle(color: Colors.white),
  ),
),


const SizedBox(height: 20),

// زر رسالة واتساب
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF002E70), // خلفية كحلي
    foregroundColor: Colors.white, // لون النص أبيض
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  onPressed: () async {
    const phoneNumber = '201028476944';
    final message = Uri.encodeComponent(
      AppLocalizations.of(context)!.customTripMessage,
    );
    final url = 'https://wa.me/$phoneNumber?text=$message';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.cannotOpenWhatsapp,
          ),
        ),
      );
    }
  },
  child: Text(
    AppLocalizations.of(context)!.customtrip,
    style: const TextStyle(
      color: Colors.white, // النص (foreground)
    ),
  ),
),

            ],
          ),
        ),
      );
    }

    return MultiBlocListener(
      listeners: [

                BlocListener<SearchTripByDateBloc, SearchTripByDateState>(
          listener: (context, state) {
            if (state is SearchTripByDateLoaded) {
              _updateTripsList(state.trips);
              context.read<TripBloc>().add(SetTripsEvent(state.trips));
            }
          },
        ),


                BlocListener<SearchTripByCategoryBloc, SearchTripByCategoryState>(
          listener: (context, state) {
            if (state is SearchTripByCategoryLoaded) {
              _updateTripsList(state.trips);

              // ✨ هنا تضيف
              context.read<TripBloc>().add(SetTripsEvent(state.trips));
            } else if (state is SearchTripByCategoryError) {
              _showErrorSnackBar(state.message);
            }
          },
        ),


                BlocListener<SearchTripBySubDestinationBloc, SearchTripBySubDestinationState>(
          listener: (context, state) {
            if (state is SearchTripBySubDestinationLoaded) {
              _updateTripsList(state.trips);
              context.read<TripBloc>().add(SetTripsEvent(state.trips));
            }
          },
        ),
      ],

      child: Scaffold(
        backgroundColor: Colors.black,
        body: NotificationListener<OverscrollNotification>(
          onNotification: (overscroll) {
            if (overscroll.overscroll < 0) {
              // المستخدم بيسحب لتحت
              fetchAllTrips();
            }
            return false;
          },

          child: RefreshIndicator(
            color: const Color(0xFF002E70),
            onRefresh: () async{
                await fetchAllTrips();
            },
          
            child: PageView.builder(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              itemCount: _trips.length + (_hasMoreData ? 1 : 0),
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                if (index >= _trips.length) {
                  return _buildLoadingIndicator();
                }
            
                final currentTrip = _trips[index];
                final destinationName = _getLocalizedDestinationName(
                  currentTrip,
                  context,
                );
                final subDestination = _getLocalizedSubDestinationName(
                  currentTrip,
                  context,
                );
                final chewieController = _chewieControllers[index];
                final hasError = _videoErrorState[index] ?? false;
            
                Widget videoWidget;
                if (hasError) {
                  videoWidget = _buildVideoErrorWidget();
                } else if (chewieController != null) {
                  videoWidget = Chewie(controller: chewieController);
                } else {
                  videoWidget = const Center(
                    child: CircularProgressIndicator(color: Color(0xFF002E70)),
                  );
                }
                
                return Stack(
                  children: [
                    Positioned.fill(
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width:
                                _videoControllers[index]?.value.size.width ??
                                screenWidth,
                            height:
                                _videoControllers[index]?.value.size.height ??
                                screenHeight,
                            child: videoWidget,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 30,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            destinationName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),



                    if(!kIsWeb)
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left:
                          Directionality.of(context) == TextDirection.rtl ? 10 : null,
                      right:
                          Directionality.of(context) == TextDirection.rtl ? null : 10,
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.search_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              
                              final result = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => const SearchPage(),
                                ),
                              );
                              widget.onSearchPressed?.call();
                          
                              if(result == true){
                                
                                 disposeAllVideos(); // وقف كل الفيديوهات القديمة
                          
                                fetchAllTrips();
                              }
                            },
                          ),
                          const SizedBox(height:2),

                              Text(
                              AppLocalizations.of(context)!.searchByDate,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal
                              ),
                            )

                        ],
                      ),
                    ),


                   if (kIsWeb && widget.onToggleFullscreen != null && !widget.isCurrentlyFullscreen!)
  Positioned(
    top: MediaQuery.of(context).padding.top + 10,
    left:
        Directionality.of(context) == TextDirection.rtl ? 10 : null,
    right:
        Directionality.of(context) == TextDirection.rtl ? null : 10,
    child: IconButton(
      icon: const Icon(
        Icons.fullscreen, 
        color: Colors.white, 
        size: 30
      ),
      onPressed: _enterFullscreen,
      style: IconButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.4),
      ),
    ),
  ),

                     if (kIsWeb && widget.onToggleFullscreen != null && !widget.isCurrentlyFullscreen!) // 👈 التعديل الجديد
                      Positioned(
                       top: MediaQuery.of(context).padding.top + 10,
                      left:
                          Directionality.of(context) == TextDirection.rtl ? 10 : null,
                      right:
                          Directionality.of(context) == TextDirection.rtl ? null : 10,
                        child: IconButton(
                          icon: const Icon(
                            Icons.fullscreen, 
                            color: Colors.white, 
                            size: 30
                          ),
                          onPressed: _enterFullscreen,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                    // -----
                    // -----
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left:
                          Directionality.of(context) == TextDirection.rtl ? null : 10,
                      right:
                          Directionality.of(context) == TextDirection.rtl ? 10 : null,
                      child: IconButton(
                        icon: Icon(
                          _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: _toggleMute,
                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.white10,
                                          padding: const EdgeInsets.all(12),
                                        ),
                        
                      ),
                    ),


                    
                    if (!kIsWeb) // الشرط: إذا لم يكن التشغيل على الويب
                    Align(
                      alignment:
                          Directionality.of(context) == TextDirection.rtl
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right:
                              Directionality.of(context) == TextDirection.ltr
                                  ? 10
                                  : 0,
                          left:
                              Directionality.of(context) == TextDirection.rtl
                                  ? 10
                                  : 0,
                        ),
                        child: RightButtons(
                          tripId: currentTrip['id'],
                          currentTripCategory: currentTrip['category'] ?? -1,
                          personCounterKey: _personCounterKeys[index],

                           // 🌟 2. استقبال الـ Callback وتحديث الحالة (State)
                        onSummaryReady: (summary) {
                          if (summary != _tripSummaryText) {
                            setState(() {
                              _tripSummaryText = summary;
                            });
                            print("✅ Summary received in VideoPlayerScreen: $_tripSummaryText");
                          }
                        },
                           selectedTripSummary: _tripSummaryText,

                      


                        onDateRangeSelected: (start, end) {
                          setState(() {
                            _rangeStart=start;
                            _rangeEnd=end;
                          });
                        },
                          onHotelSelected: updateSelectedHotel,
                          onCarSelected: updateSelectedCar,
                          onActivitySelected: updateSelectedActivity,
                          onFlightSelected: updateSelectedFlight,
                        ),
                      ),
                    ),
                    ///////////////////////////////////////////////////////
                    ///


Positioned(
  bottom: kIsWeb ? screenHeight * 0.12 : screenHeight * 0.18, // توازن على الويب
   left: Directionality.of(context) == TextDirection.rtl
      ? null
      : kIsWeb
          ? screenWidth * 0.02 - screenWidth * 0.01 // تقريب من الطرف الأيسر (الويب)
          : screenWidth * 0.060 - screenWidth * 0.025,
  right: Directionality.of(context) == TextDirection.rtl
      ? (kIsWeb ? screenWidth * 0.03 - screenWidth * 0.01 : screenWidth * 0.060 - screenWidth * 0.025) // تقريب من الطرف الأيمن (الويب)
      : null,
  child: ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: kIsWeb ? screenWidth * 0.5 : screenWidth * 0.9,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kIsWeb ? screenWidth * 0.01 : screenWidth * 0.025,
          ),
          child: Countrywithcity(
            countryName: destinationName,
            cityName: subDestination,
          ),
        ),
         SizedBox(height: screenHeight * 0.001), // تم تقليلها للنصف  
      PersonCounterWithPrice(
          key: _personCounterKeys[index],
          basePricePerPerson:
              double.tryParse(currentTrip['price_per_person']?.toString() ?? '0') ?? 0,
          maxPersons: currentTrip['max_persons'] ?? 30,
          textColor: Colors.white,
          iconColor: Colors.black,
          backgroundColor: Colors.white,
          carPrice: selectedCarPrice,
        ),
        const SizedBox(height:2),
         Padding(
          padding: EdgeInsets.only(
            left: kIsWeb ? screenWidth * 0.015 : screenWidth * 0.05, 
            right: kIsWeb ? screenWidth * 0.015 : screenWidth * 0.05, 

          ),
          child: SizedBox(
            width: kIsWeb ? screenWidth * 0.4 : 250,
            child: Text(
              _tripSummaryText ?? AppLocalizations.of(context)!.priceInfoDefault,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  ),
),

Positioned(
  bottom: kIsWeb ? screenHeight * 0.05 : screenHeight * 0.12,
  left: 20,
  right: 20,
  child: Center(
    child: BlocConsumer<OrderTripBloc, OrderTripState>(
      listener: (context, state) {
        if (state is OrderTripSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Order created successfully ✅")),
          );
        } else if (state is OrderTripFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.error}")),
          );
        }
      },
      builder: (context, state) {
        if (state is OrderTripLoading) {
          return const CircularProgressIndicator(color: Colors.white);
        }
        return SizedBox(
          width: kIsWeb ? screenWidth * 0.4 : screenWidth * 0.80,
          height: 45,
          child: CustomButton(
            text: AppLocalizations.of(context)!.booknow,
            onPressed: () async {
              final storage = SecureStorageService();
              final currentUser = await storage.getUser();
              final personCounterState = _personCounterKeys[index].currentState;

              final orderData = {
                "trip_id": currentTrip['id'],
                "user_id": currentUser!['id'],
                "sub_destination_id": currentTrip['sub_destination']?['id'],
                "customer_name": currentUser['name'],
                "customer_email": currentUser['email'],
                "customer_phone": currentUser['phone'],
                "persons": personCounterState?.currentPersons ?? 1,
                "total_price": personCounterState?.totalPrice ?? 0.0,
                "status": "pending",
                "note": "",
                "fly_id": selectedFlyId,
                "from_date": _rangeStart != null
                    ? DateFormat('yyyy-MM-dd').format(_rangeStart!)
                    : null,
                "to_date": _rangeEnd != null
                    ? DateFormat('yyyy-MM-dd').format(_rangeEnd!)
                    : null,
                "hotel_id": selectedHotelId,
                "hotel_price": selectedHotelPrice ?? 0.0,
                "car_id": selectedCarId,
                "car_price": selectedCarPrice,
                "activity_id": selectedActivityId,
                "activity_price": selectedActivityPrice,
              };

              debugPrint("==== Trip DATA SENT TO API ====\n${const JsonEncoder.withIndent('  ').convert(orderData)}");
              context.read<OrderTripBloc>().add(SubmitOrderTrip(orderData));
            },
          ),
        );
      },
    ),
  ),
),

                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _updateTripsList(List<GetTripModel> trips) {
    if (!mounted) return;
    // أول حاجة: اقفل كل الفيديوهات القديمة
    disposeAllVideos();

    final newTrips = trips.map((tripModel) => tripModel.toVideoPlayerJson()).toList();

    setState(() {
      _currentPage = 0;
      _isLoadingMore = false;
      _hasMoreData = newTrips.length > _perPage;
      _trips = newTrips;
      _personCounterKeys = List.generate(
        _trips.length,
        (index) => GlobalKey<PersonCounterWithPriceState>(),
      );
      _isLoadingFirstPage = false;
      _initialErrorMessage =
          _trips.isEmpty ? AppLocalizations.of(context)!.noTrips : "";
    });

    // ✨ بعد ما يتعمل setState وتخلص، نرجّع الـ PageView لأول صفحة ونجهّز الفيديو
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpToPage(0);
      }
      if (_trips.isNotEmpty) {
        _initializeAndPreloadVideo(0, autoPlay: true);
        if (_trips.length > 1) _initializeAndPreloadVideo(1);
      }
    });
  }


  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
    setState(() {
      _initialErrorMessage = message;
    });
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF002E70)),
    );
  }

  Widget _buildVideoErrorWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, size: 50, color: Colors.white),
          SizedBox(height: 16),
          Text(
            "Video could not be loaded",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getLocalizedDestinationName(
    Map<String, dynamic> trip,
    BuildContext context,
  ) {
    try {
      final locale = Localizations.localeOf(context).languageCode;
      if (trip['destination'] != null) {
        return locale == 'ar'
            ? trip['destination']['name_ar']?.toString() ??
                trip['destination']['name_en']?.toString() ??
                'Unknown'
            : trip['destination']['name_en']?.toString() ??
                trip['destination']['name_ar']?.toString() ??
                'Unknown';
      }
      return locale == 'ar'
          ? trip['destination_name_ar']?.toString() ??
              trip['destination_name_en']?.toString() ??
              'Unknown'
          : trip['destination_name_en']?.toString() ??
              trip['destination_name_ar']?.toString() ??
              'Unknown';
    } catch (e) {
      debugPrint('Error getting destination name: $e');
      return 'Unknown';
    }
  }

  String _getLocalizedSubDestinationName(
    Map<String, dynamic> trip,
    BuildContext context,
  ) {
    try {
      final locale = Localizations.localeOf(context).languageCode;
      if (trip['sub_destination'] != null) {
        return locale == 'ar'
            ? trip['sub_destination']['name_ar']?.toString() ??
                trip['sub_destination']['name_en']?.toString() ??
                ''
            : trip['sub_destination']['name_en']?.toString() ??
                trip['sub_destination']['name_ar']?.toString() ??
                '';
      }
      return locale == 'ar'
          ? trip['sub_destination_name_ar']?.toString() ??
              trip['sub_destination_name_en']?.toString() ??
              ''
          : trip['sub_destination_name_en']?.toString() ??
              trip['sub_destination_name_ar']?.toString() ??
              '';
    } catch (e) {
      debugPrint('Error getting sub-destination name: $e');
      return '';
    }
  }
}