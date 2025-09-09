import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_event.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_repository.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_State.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_State.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_State.dart';
import 'package:tripto/presentation/pages/NavBar/homePage/search/SearchDialog.dart';
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
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';


class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

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
  double selectedCarPrice = 0.0;
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchAllTrips();
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

  Future<void> _fetchAllTrips() async {
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
      final directLink = _isDriveUrl(videoUrl)
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

  void _disposeAllVideos() {
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
              const Icon(Icons.search_off, color: Colors.white, size: 50),
              const SizedBox(height: 20),
              Text(
                _initialErrorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002E70), // خلفية كحلي
                foregroundColor: Colors.white, // لون النص أبيض
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
                onPressed: () {
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
                },
                  child: Text(AppLocalizations.of(context)!.backToAllTrips,
                    style: TextStyle(
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
            } else if (state is SearchTripByDateError) {
              _showErrorSnackBar(state.message);
            }
          },
        ),
        BlocListener<SearchTripByCategoryBloc, SearchTripByCategoryState>(
          listener: (context, state) {
            if (state is SearchTripByCategoryLoaded) {
              _updateTripsList(state.trips);
            } else if (state is SearchTripByCategoryError) {
              _showErrorSnackBar(state.message);
            }
          },
        ),
        BlocListener<SearchTripBySubDestinationBloc, SearchTripBySubDestinationState>(
          listener: (context, state) {
            if (state is SearchTripBySubDestinationLoaded) {
              _updateTripsList(state.trips);
            } else if (state is SearchTripBySubDestinationError) {
              _showErrorSnackBar(state.message);
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
              _fetchAllTrips();
            }
            return false;
          },

          child: RefreshIndicator(
            color: const Color(0xFF002E70),
            onRefresh: () async{
                await _fetchAllTrips();
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

                                // 1️⃣ إعادة تحميل كل الرحلات في السيرش

                          final result = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => Dialog(
                              backgroundColor: Colors.white.withOpacity(0.95),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SearchDialog(),
                              ),
                            ),
                          );
                          if(result == true){
                            
                             _disposeAllVideos(); // وقف كل الفيديوهات القديمة

                            _fetchAllTrips();
                          }
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
                         // currentTripCategory: currentTrip['category'] ?? -1,
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
                              maxPersons: currentTrip['max_persons'] ?? 30,
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
          ),
        ),
      ),
    );
  }

void _updateTripsList(List<GetTripModel> trips) {
  if (!mounted) return;
  _disposeAllVideos();

  final filteredTrips = trips.map((trip) => trip.toVideoPlayerJson()).toList();

  setState(() {
    _trips = filteredTrips;
    _personCounterKeys = List.generate(
      filteredTrips.length,
      (index) => GlobalKey<PersonCounterWithPriceState>(),
    );
    _currentIndex = 0;
    _isLoadingFirstPage = false;
    _hasMoreData = filteredTrips.length > _perPage;
    _currentPage = 0;
  });

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _scrollController.jumpToPage(0);
    if (_trips.isNotEmpty) _initializeAndPreloadVideo(0, autoPlay: true);
    if (_trips.length > 1) _initializeAndPreloadVideo(1);
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