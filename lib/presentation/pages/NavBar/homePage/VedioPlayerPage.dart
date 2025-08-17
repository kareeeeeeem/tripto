import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_event.dart';
import 'package:tripto/data/repositories/TripsRepository.dart';
import 'package:tripto/presentation/pages/SlideBar/RightButtons.dart';
import 'package:tripto/presentation/pages/widget/CountryWithCity.dart';
import 'package:tripto/presentation/pages/widget/PersonCounterWithPrice.dart';
import 'package:tripto/presentation/pages/widget/payment_option.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/core/constants/CustomButton.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/main.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final _storage = const FlutterSecureStorage();
  final _scrollController = PageController();
  final double _bookingPricePerPerson = 250.0;
  double selectedCarPrice = 0.0;
  List<GlobalKey<PersonCounterWithPriceState>> _personCounterKeys = [];

  List<Map<String, dynamic>> _trips = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  bool _isVideoInitializing = false;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isMuted = false;
  bool _isInternetAvailable = true;
  Timer? _pageChangeTimer; // ضيفها فوق في الكلاس

  // Video controllers
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  Timer? _retryTimer;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _fetchTrips();

    _scrollController.addListener(() {
      final newIndex = _scrollController.page?.round() ?? 0;
      final bloc = context.read<GetTripBloc>();

      if (bloc.currentIndex != newIndex && newIndex < _trips.length) {
        bloc.add(ChangeCurrentTripEvent(newIndex));
      }
    });
  }

  Future<void> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      setState(() {
        _isInternetAvailable =
            result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      });
    } on SocketException catch (_) {
      setState(() => _isInternetAvailable = false);
    }
  }

  Future<void> _fetchTrips() async {
    if (!_isInternetAvailable) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'No internet connection';
      });
      return;
    }

    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      final trips = await TripsRepository().fetchTrips();

      if (trips.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'No trips available';
        });
        return;
      }

      setState(() {
        _trips = trips.map((trip) => trip.toVideoPlayerJson()).toList();
        _isLoading = false;

        _personCounterKeys = List.generate(
          _trips.length,
          (index) => GlobalKey<PersonCounterWithPriceState>(),
        );
      });

      await _initializeVideo(0);
    } catch (e) {
      debugPrint('Error fetching trips');
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage =
            e.toString().contains('HTML')
                ? 'Server error: Please try again later'
                : 'Loading:';
      });
    }
  }

  Future<void> _initializeVideo(int index) async {
    context.read<GetTripBloc>().add(ChangeCurrentTripEvent(index));
    if (_videoController != null && index != _currentIndex) {
      _videoController!.pause();
    }

    _disposeCurrentVideo();
    setState(() {
      _isVideoInitializing = true;
      _hasError = false;
      _currentIndex = index;
    });

    try {
      final videoUrl = _trips[index]['video_url']?.toString() ?? '';
      if (videoUrl.isEmpty) throw Exception('No video URL available');

      if (_isDriveUrl(videoUrl)) {
        final directLink = await _getDirectDriveLink(videoUrl);
        print("Google Drive direct link: $directLink");

        _videoController = VideoPlayerController.network(directLink);

        _videoController!.addListener(() {
          if (_videoController!.value.hasError) {
            setState(() {
              _hasError = true;
              _errorMessage = 'Loading';
            });
          }
        });

        await _videoController!.initialize();
        _videoController!.setVolume(_isMuted ? 0.0 : 1.0);

        _chewieController = ChewieController(
          videoPlayerController: _videoController!,
          autoPlay: true,
          looping: true,
          allowFullScreen: false,
          showControls: false, // لمنع ظهور شريط التحكم وأيقونة الصوت

          errorBuilder: (context, errorMessage) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cloud_off, size: 50, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _initializeVideo(_currentIndex),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        _videoController = VideoPlayerController.network(videoUrl);
        await _videoController!.initialize();
        _videoController!.setVolume(_isMuted ? 0.0 : 1.0);
        _chewieController = ChewieController(
          videoPlayerController: _videoController!,
          autoPlay: true,
          looping: true,
          allowFullScreen: false,
        );
      }
    } catch (e) {
      debugPrint('Video initialization error:');
      setState(() {
        _hasError = true;
        _errorMessage = 'Loading';
      });
      _startRetryTimer(index);
    } finally {
      if (mounted) {
        setState(() => _isVideoInitializing = false);
      }
    }
  }

  void _startRetryTimer(int index) {
    _retryTimer?.cancel();
    _retryTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _currentIndex == index) {
        _initializeVideo(index);
      }
    });
  }

  bool _isDriveUrl(String url) {
    return url.contains('drive.google.com');
  }

  String? _extractDriveId(String url) {
    final regExp1 = RegExp(r'file/d/([a-zA-Z0-9_-]+)');
    final regExp2 = RegExp(r'id=([a-zA-Z0-9_-]+)');

    if (regExp1.hasMatch(url)) {
      return regExp1.firstMatch(url)?.group(1);
    } else if (regExp2.hasMatch(url)) {
      return regExp2.firstMatch(url)?.group(1);
    }
    return null;
  }

  Future<String> _getDirectDriveLink(String driveUrl) async {
    final videoId = _extractDriveId(driveUrl);
    if (videoId != null) {
      return 'https://drive.google.com/uc?export=download&id=$videoId';
    }
    return driveUrl;
  }

  Future<void> _openInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint('Could not launch $url');
    }
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

  void _disposeCurrentVideo() {
    _retryTimer?.cancel();
    _videoController?.dispose();
    _videoController = null;
    _chewieController?.dispose();
    _chewieController = null;
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      if (_videoController != null) {
        _videoController!.setVolume(_isMuted ? 0.0 : 1.0);
      }
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
    _disposeCurrentVideo();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
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

    if (_hasError && _trips.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isInternetAvailable ? Icons.error : Icons.wifi_off,
                color: Colors.white,
                size: 50,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchTrips,
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
        itemCount: _trips.length,
        onPageChanged: (index) {
          _pageChangeTimer?.cancel();
          _pageChangeTimer = Timer(const Duration(milliseconds: 300), () {
            _initializeVideo(index);
          });
        },
        itemBuilder: (context, index) {
          final currentTrip = _trips[index];
          final destinationName = _getLocalizedDestinationName(
            currentTrip,
            context,
          );
          final subDestination = _getLocalizedSubDestinationName(
            currentTrip,
            context,
          );

          return Stack(
            children: [
              // Video Background
              if (_isVideoInitializing && index == _currentIndex)
                const Center(child: CircularProgressIndicator())
              else if (_hasError && index == _currentIndex)
                _buildVideoErrorWidget(currentTrip['video_url'])
              else
                Positioned.fill(child: _buildVideoPlayer()),

              // Destination في الأعلى بالمنتصف
              Positioned(
                top:
                    MediaQuery.of(context).padding.top +
                    30, // تحت الـ status bar
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.language,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: _handleLanguageChange,
                    ),
                  ],
                ),
              ),

              // Overlay UI Elements
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left:
                    Directionality.of(context) == TextDirection.rtl ? null : 10,
                right:
                    Directionality.of(context) == TextDirection.rtl ? 10 : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isMuted ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: _toggleMute,
                    ),
                  ],
                ),
              ),

              // Right Buttons
              Container(
                child: Align(
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
                      currentTripCategory: _trips[index]['category'] ?? 0,
                      personCounterKey: _personCounterKeys[index],
                    ),
                  ),
                ),
              ),

              // Destination Info
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
                            _trips[_currentIndex]['price_per_person']
                                    ?.toString() ??
                                '0',
                          ) ??
                          0,
                      maxPersons: _trips[_currentIndex]['max_person'] ?? 30,
                      textColor: Colors.white,
                      iconColor: Colors.black,
                      backgroundColor: Colors.white,
                      carPrice: selectedCarPrice,
                    ),
                  ],
                ),
              ),

              // Book Now Button
              Positioned(
                bottom: screenHeight * 0.12,
                left: 20,
                right: 20,
                child: Center(
                  child: CustomButton(
                    text: AppLocalizations.of(context)!.booknow,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentOption(),
                        ),
                      );
                    },
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

  Widget _buildVideoPlayer() {
    if (_chewieController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final videoSize = _chewieController!.videoPlayerController.value.size;

    return SizedBox.expand(
      // ياخد كل مساحة الشاشة
      child: FittedBox(
        fit: BoxFit.cover, // يخلي الفيديو يغطي الشاشة بالكامل
        child: SizedBox(
          width: videoSize.width,
          height: videoSize.height,
          child: Chewie(controller: _chewieController!),
        ),
      ),
    );
  }

  Widget _buildVideoErrorWidget(String videoUrl) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, size: 50, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            _errorMessage,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: () => _openInBrowser(videoUrl),
          //   child: const Text('Open in Browser'),
          // ),
          const SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: () => _initializeVideo(_currentIndex + 1),
          //   child: const Text('Skip to next'),
          // ),
        ],
      ),
    );
  }
}
