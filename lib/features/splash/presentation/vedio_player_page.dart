import 'package:flutter/material.dart';
import 'package:tripto/core/constants/const_right_buttons.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final List<String> videoUrls = [
   
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
  'https://samplelib.com/lib/preview/mp4/sample-10s.mp4',
  'https://samplelib.com/lib/preview/mp4/sample-15s.mp4',
  'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
  'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4',
  
   // Add more video URLs as needed
  ];

  late VideoPlayerController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initializeVideo(_currentPage);
  }

  Future<void> _initializeVideo(int index) async {
    if (mounted && index < videoUrls.length) {
      _controller = VideoPlayerController.network(videoUrls[index]);
      await _controller.initialize();
      _controller.setLooping(true);
      _controller.setVolume(0.0);
      await _controller.play();
      setState(() {});
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
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '🎬 فيديو',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
