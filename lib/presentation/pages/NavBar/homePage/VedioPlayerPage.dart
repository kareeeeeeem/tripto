import 'dart:async';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_event.dart';
import 'package:tripto/bloc/Repositories/TripsRepository.dart';
import 'package:tripto/presentation/pages/NavBar/homePage/searchDialog.dart';
import 'package:tripto/presentation/pages/SlideBar/RightButtons.dart';
import 'package:tripto/presentation/pages/screens/leftSide/CountryWithCity.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';
import 'package:tripto/presentation/pages/screens/payment/payment_option.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/core/constants/CustomButton.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/main.dart';
// import 'package:url_launcher/url_launcher.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen>
    with WidgetsBindingObserver, RouteAware {
  // --- الثوابت والمتغيرات الأصلية الخاصة بك ---
  // ignore: unused_field
  final _storage = const FlutterSecureStorage();
  final _scrollController = PageController();
  // ignore: unused_field
  final double _bookingPricePerPerson = 0.0;
  double selectedCarPrice = 0.0;
  List<GlobalKey<PersonCounterWithPriceState>> _personCounterKeys = [];
  List<Map<String, dynamic>> _allTrips = []; // كل الرحلات
  List<Map<String, dynamic>> _trips = []; // الرحلات المعروضة حالياً
  int _currentIndex = 0;
  bool _isMuted = false;

  // --- متغيرات الحالة لإدارة الفيديو والتحميل ---
  final Map<int, VideoPlayerController> _videoControllers = {};
  final Map<int, ChewieController> _chewieControllers = {};
  final Map<int, bool> _videoErrorState = {};

  // --- متغيرات للتحميل الكسول (Lazy Loading) ---
  bool _isLoadingFirstPage = true;
  String _initialErrorMessage = '';
  int _currentPage = 0; // الصفحة الحالية
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  final int _perPage = 5; // عدد الفيديوهات التي يتم تحميلها في كل مرة

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // <-- أضف هذا السطر

    _fetchAllTrips(); // نبدأ بتحميل كل الرحلات أولاً
  }

  // ✅ الخطوة 2: أضف didChangeDependencies للاشتراك
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // اشترك في مراقب التنقل
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

  // --- جلب كل الرحلات مرة واحدة ---
  Future<void> _fetchAllTrips() async {
    setState(() {
      _isLoadingFirstPage = true;
      _initialErrorMessage = '';
    });

    try {
      final allTripsData = await TripsRepository().fetchTrips();
      if (!mounted) return;

      if (allTripsData.isEmpty) {
        setState(() {
          _initialErrorMessage = 'No trips available';
          _isLoadingFirstPage = false;
        });
        return;
      }

      // تحويل إلى التنسيق المطلوب
      final allTrips =
          allTripsData.map((trip) => trip.toVideoPlayerJson()).toList();

      setState(() {
        _allTrips = allTrips;
        _trips = allTrips.take(_perPage).toList(); // أخذ أول دفعة
        _personCounterKeys = List.generate(
          _trips.length,
          (index) => GlobalKey<PersonCounterWithPriceState>(),
        );
        _isLoadingFirstPage = false;
        _hasMoreData = _allTrips.length > _perPage;
      });

      // تحميل الفيديو الحالي (وتشغيله) والفيديو التالي
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

  // --- جلب المزيد من البيانات عند التمرير (Lazy Loading) ---
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
      // توسيع قائمة المفاتيح لتشمل الرحلات الجديدة
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

  // --- دالة موحدة للتهيئة والتحميل المسبق ---
  Future<void> _initializeAndPreloadVideo(
    int index, {
    bool autoPlay = false,
  }) async {
    if (_videoControllers.containsKey(index) || index >= _trips.length) return;

    final videoUrl = _trips[index]['video_url']?.toString() ?? '';
    if (videoUrl.isEmpty) {
      if (mounted) setState(() => _videoErrorState[index] = true);
      return;
    }

    try {
      final directLink =
          _isDriveUrl(videoUrl)
              ? await _getDirectDriveLink(videoUrl)
              : videoUrl;
      final controller = VideoPlayerController.network(directLink);
      _videoControllers[index] = controller;
      await controller.initialize();

      final chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: autoPlay,
        looping: true,
        showControls: false,
        allowFullScreen: false,
        // _isMuted: _isMuted ? 0.0 : 1.0,
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

  // --- دالة تغيير الصفحة هي التي تدير كل شيء ---
  void _onPageChanged(int index) {
    // إيقاف الفيديو السابق
    if (_chewieControllers.containsKey(_currentIndex)) {
      _chewieControllers[_currentIndex]?.pause();
    }

    // تشغيل الفيديو الحالي
    final currentChewieController = _chewieControllers[index];
    if (currentChewieController != null) {
      currentChewieController.play();
      currentChewieController.setVolume(_isMuted ? 0.0 : 1.0);
    } else {
      // إذا لم يكن الفيديو جاهزًا، قم بتهيئته وتشغيله
      _initializeAndPreloadVideo(index, autoPlay: true);
    }

    setState(() => _currentIndex = index);

    context.read<GetTripBloc>().add(ChangeCurrentTripEvent(index));

    // التخلص من الفيديوهات البعيدة
    _disposeDistantVideos(index);

    // تحميل الفيديو التالي والسابق
    if (index + 1 < _trips.length) {
      _initializeAndPreloadVideo(index + 1);
    }
    if (index - 1 >= 0) {
      _initializeAndPreloadVideo(index - 1);
    }

    // جلب المزيد من البيانات عند الاقتراب من النهاية
    if (index >= _trips.length - 2 && !_isLoadingMore && _hasMoreData) {
      _fetchMoreTrips();
    }
  }

  // --- التخلص من المتحكمات البعيدة لتحرير الذاكرة ---
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

  // --- الدوال المساعدة الأصلية ---
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

  void _handleLanguageChange() {
    final currentLocale = Localizations.localeOf(context).languageCode;
    final newLocale =
        currentLocale == 'ar' ? const Locale('en') : const Locale('ar');
    TripToApp.setLocale(context, newLocale);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // <-- أضف هذا السطر
    routeObserver.unsubscribe(this); // ✅ ألغِ الاشتراك

    _scrollController.dispose();
    _videoControllers.forEach((_, controller) => controller.dispose());
    _chewieControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  void didPushNext() {
    // أوقف الفيديو الحالي
    _chewieControllers[_currentIndex]?.pause();
    debugPrint("Navigated away from VideoPlayerScreen, pausing video.");
  }

  /// يتم استدعاؤها عند العودة إلى هذه الصفحة من صفحة أخرى
  @override
  void didPopNext() {
    // أعد تشغيل الفيديو الحالي
    _chewieControllers[_currentIndex]?.play();
    debugPrint("Returned to VideoPlayerScreen, playing video.");
  }

  //////////////////////////////
  void pauseCurrentVideo() {
    _chewieControllers[_currentIndex]?.pause();
  }

  void playCurrentVideo() {
    _chewieControllers[_currentIndex]?.play();
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
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 20),
              Text(
                'Loading trips...',
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
              const Icon(Icons.error_outline, color: Colors.white, size: 50),
              const SizedBox(height: 20),
              Text(
                _initialErrorMessage,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchAllTrips,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: _trips.length + (_hasMoreData ? 1 : 0), // +1 لشعار التحميل
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          // إذا كان هذا هو العنصر الأخير وهناك المزيد من البيانات
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
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return Stack(
            children: [
              // عرض الفيديو
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

              // باقي واجهتك الأصلية
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
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left:
                    Directionality.of(context) == TextDirection.rtl ? 10 : null,
                right:
                    Directionality.of(context) == TextDirection.rtl ? null : 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.search_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder:
                          (context) => Dialog(
                            backgroundColor: Colors.white, // 🔹 الخلفية بيضاء

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SearchDialog(),
                            ),
                          ),
                    );
                  },
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left:
                    Directionality.of(context) == TextDirection.rtl ? null : 10,
                right:
                    Directionality.of(context) == TextDirection.rtl ? 10 : null,
                child: IconButton(
                  icon: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _toggleMute,
                ),
              ),
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
                    selectedTripIndex: index,
                    currentTripCategory: currentTrip['category'] ?? 0,
                    personCounterKey: _personCounterKeys[index],
                  ),
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.18,
                left:
                    Directionality.of(context) == TextDirection.rtl
                        ? null
                        : screenWidth * 0.060,
                right:
                    Directionality.of(context) == TextDirection.rtl
                        ? screenWidth * 0.060
                        : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left:
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? 0
                                : screenWidth * 0.025,
                        right:
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? screenWidth * 0.025
                                : 0,
                      ),
                      child: Countrywithcity(
                        countryName: destinationName,
                        cityName: subDestination,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    PersonCounterWithPrice(
                      key: _personCounterKeys[index],
                      basePricePerPerson:
                          double.tryParse(
                            currentTrip['price_per_person']?.toString() ?? '0',
                          ) ??
                          0,
                      maxPersons: currentTrip['max_person'] ?? 30,
                      textColor: Colors.white,
                      iconColor: Colors.black,
                      backgroundColor: Colors.white,
                      carPrice: selectedCarPrice,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.12,
                left: 20,
                right: 20,
                child: Center(
                  child: CustomButton(
                    text: AppLocalizations.of(context)!.booknow,
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentOption(),
                          ),
                        ),
                    width: screenWidth * 0.80,
                    height: 40,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // دالة لبناء مؤشر التحميل للصفحات الإضافية
  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator(color: Colors.white));
  }

  // دوال مساعدة إضافية
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
