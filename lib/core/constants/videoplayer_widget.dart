import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoplayerWidget extends StatefulWidget {
  final String Url;
  const VideoplayerWidget({super.key, required this.Url});

  @override
  State<VideoplayerWidget> createState() => _VideoplayerWidgetState();
}

class _VideoplayerWidgetState extends State<VideoplayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.Url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {}); // لتحديث الواجهة بعد تهيئة الفيديو
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading video: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
