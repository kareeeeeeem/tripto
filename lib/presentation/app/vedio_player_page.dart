import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final List<String> videoUrls = [
    'https://media.w3.org/2010/05/sintel/trailer.mp4',
    'https://media.w3.org/2010/05/bunny/trailer.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/elephant.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/horse.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://filesamples.com/samples/video/mp4/sample_960x400_ocean_with_audio.mp4',
  ];

  late VideoPlayerController _controller;
  int _currentPage = 0;
  bool _hasError = false;
  String _errorMessage = '';

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

      _controller = VideoPlayerController.network(videoUrls[index]);
      await _controller.initialize();
      _controller.setLooping(true);
      _controller.setVolume(1.0);
      await _controller.play();

      setState(() {});
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Video loading failed. Please try again later.';
        print('Video error: $e');
      });
    }
  }

  Future<void> _changeVideo(int newIndex) async {
    await _controller.pause();
    await _controller.dispose();
    setState(() => _currentPage = newIndex);
    await _initializeVideo(newIndex);
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
            return const Center(child: CircularProgressIndicator());
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
                    child: const Text(' try again'),
                  ),
                ],
              ),
            );
          }

          return _controller.value.isInitialized
              ? Stack(
                fit: StackFit.expand,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ],
              )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
