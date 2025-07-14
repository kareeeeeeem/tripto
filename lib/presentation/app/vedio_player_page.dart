import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:tripto/core/constants/CustomButton.dart'; // تأكد من استيراده
import 'package:tripto/presentation/pagess/PersonCounterWithPriceWithCountry.dart'; // تأكد من استيراده
import 'package:tripto/presentation/pagess/RightButtonsPages/RightButtons.dart'; // تأكد من استيراده
import 'package:tripto/presentation/pagess/payment_option.dart'; // تأكد من استيراده

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final List<String> videoUrls = [
    'assets/images/vedio2.mp4',
    'assets/images/vedio1.mp4',
    'assets/images/vedio3.mp4',
    'assets/images/vedio4.mp4',
    'assets/images/vedio5.mp4',
    'assets/images/vedio6.mp4',
    'assets/images/vedio7.mp4',
    'assets/images/vedio8.mp4',
  ];

  late VideoPlayerController _controller;
  int _currentPage = 0;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isMuted = false;
  final double _bookingPricePerPerson = 250.0; // نقلها إلى هنا

  @override
  void initState() {
    super.initState();
    _initializeVideo(_currentPage);
  }

  Future<void> _initializeVideo(int index) async {
    try {
      setState(() {
        _hasError = false;
        _errorMessage = '';
      });

      _controller = VideoPlayerController.asset(videoUrls[index]);
      await _controller.initialize();
      _controller.setLooping(true);
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
      await _controller.play();

      setState(() {});
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'فشل تشغيل الفيديو المحلي. يرجى التأكد من المسار.';
        print('خطأ في الفيديو المحلي: $e');
      });
    }
  }

  Future<void> _changeVideo(int newIndex) async {
    if (_controller.value.isInitialized) {
      await _controller.pause();
      await _controller.dispose();
    }
    setState(() {
      _currentPage = newIndex;
      _isMuted = false;
    });
    await _initializeVideo(newIndex);
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      if (_isMuted) {
        _controller.setVolume(0.0);
      } else {
        _controller.setVolume(1.0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        onPageChanged: _changeVideo,
        itemBuilder: (context, index) {
          // إذا لم تكن هذه هي الصفحة الحالية، اعرض مؤشر التحميل فقط
          if (index != _currentPage) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          // عرض رسالة الخطأ إذا كان هناك خطأ في تشغيل الفيديو
          if (_hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 12),
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _initializeVideo(_currentPage),
                    child: const Text('أعد المحاولة'),
                  ),
                ],
              ),
            );
          }

          // عرض الفيديو والعناصر المتراكبة عليه
          return _controller.value.isInitialized
              ? Stack(
                fit: StackFit.expand,
                children: [
                  // مشغل الفيديو
                  GestureDetector(
                    onTap: _toggleMute, // يمكن التفاعل مع الفيديو بالنقر
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),

                  // زر كتم/إظهار الصوت (متحرك مع الفيديو)
                  Positioned(
                    top: screenHeight * 0.07,
                    left: screenWidth * 0.05,
                    child: GestureDetector(
                      onTap: _toggleMute,
                      child: Icon(
                        _isMuted ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),

                  // عنوان الدولة (متحرك مع الفيديو)
                  Positioned(
                    top: screenHeight * 0.1, // نفس الارتفاع النسبي
                    right: screenWidth * 0.38, // نفس الموقع النسبي
                    child: const Text(
                      'Egypt', // سيتم تكراره لكل فيديو، إذا أردت تغيير الدولة لكل فيديو، تحتاج لقائمة من أسماء الدول
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // الأزرار الجانبية (RightButtons) (متحركة مع الفيديو)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: screenHeight * 0.5,
                        child: const RightButtons(),
                      ),
                    ),
                  ),

                  // نص المدينة وعداد الأشخاص (متحرك مع الفيديو)
                  Positioned(
                    bottom: screenHeight * 0.20, // نفس الارتفاع النسبي
                    left: 20,
                    right: screenWidth * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alex, Egypt', // سيتم تكراره لكل فيديو، إذا أردت تغيير المدينة، تحتاج لقائمة من أسماء المدن
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black54,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 1),
                        PersonCounterWithPriceWithContry(
                          basePricePerPerson: _bookingPricePerPerson,
                          textColor: Colors.white,
                          iconColor: Colors.black,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),

                  // زر Book Now (متحرك مع الفيديو)
                  Positioned(
                    bottom: screenHeight * 0.12, // نفس الارتفاع النسبي
                    left: 20,
                    right: 20,
                    child: Center(
                      child: CustomButton(
                        text: "Book Now",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentOption(),
                            ),
                          );
                        },
                        width: screenWidth * 0.80,
                        height: 40,
                      ),
                    ),
                  ),
                ],
              )
              : const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
        },
      ),
    );
  }
}
