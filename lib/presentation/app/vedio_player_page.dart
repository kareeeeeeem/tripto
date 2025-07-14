import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  // **تعديل قائمة الـ URLs لتبقى مسارات ملفات لوكال**
  final List<String> videoUrls = [
    // تم إصلاح الأخطاء هنا: كل المسارات الآن بين علامات اقتباس
    'assets/images/vedio2.mp4',
    'assets/images/vedio1.mp4',
    'assets/images/vedio3.mp4',
    'assets/images/vedio4.mp4',
    'assets/images/vedio5.mp4',
    'assets/images/vedio6.mp4',
    'assets/images/vedio7.mp4',
    'assets/images/vedio8.mp4',

    // أضف كل مسارات فيديوهاتك هنا
  ];

  late VideoPlayerController _controller;
  int _currentPage = 0;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isMuted = false; // تبدأ الفيديوهات بالصوت افتراضيًا

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

      // **التعديل هنا: استخدام VideoPlayerController.asset**
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
    // التأكد أن الـ controller مش null قبل الـ dispose
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        onPageChanged: _changeVideo,
        itemBuilder: (context, index) {
          if (index != _currentPage) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

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

          return _controller.value.isInitialized
              ? Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: _toggleMute,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.07,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: GestureDetector(
                      onTap: _toggleMute,
                      child: Icon(
                        _isMuted ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                        size: 30,
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
