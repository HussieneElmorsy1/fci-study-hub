import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart'; // للتعامل مع الاتجاه

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool isFullScreen = false;
  double _playbackSpeed = 1.0; // السرعة الافتراضية

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // تشغيل الفيديو تلقائيًا
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // تنظيف الذاكرة عند الخروج
    super.dispose();
  }

  // تغيير الاتجاه بين portrait و landscape
  void _toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
    });
    if (isFullScreen) {
      // تغيير الاتجاه إلى landscape
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    } else {
      // العودة إلى portrait
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  // تغيير سرعة الفيديو
  void _changePlaybackSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
      _controller.setPlaybackSpeed(_playbackSpeed); // تغيير السرعة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تشغيل الفيديو'),
        actions: [
          IconButton(
            icon: Icon(isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
            onPressed: _toggleFullScreen, // التعامل مع ملء الشاشة
          ),
          // زر السرعة
          PopupMenuButton<double>(
            icon: const Icon(Icons.speed),
            onSelected: _changePlaybackSpeed,
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text('0.5x'), value: 0.5),
                PopupMenuItem(child: Text('1x'), value: 1.0),
                PopupMenuItem(child: Text('1.5x'), value: 1.5),
                PopupMenuItem(child: Text('2x'), value: 2.0),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        // التحقق من الحجم في وضع ملء الشاشة
                        aspectRatio: isFullScreen
                            ? MediaQuery.of(context).size.aspectRatio
                            : _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),

                  // شريط تقدم الفيديو
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Colors.blue,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.black,
                    ),
                  ),

                  // أدوات التحكم: رجوع، تشغيل/إيقاف، تقديم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.replay_10),
                        onPressed: () {
                          final currentPosition = _controller.value.position;
                          _controller.seekTo(currentPosition - const Duration(seconds: 10));
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying ? _controller.pause() : _controller.play();
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.forward_10),
                        onPressed: () {
                          final currentPosition = _controller.value.position;
                          _controller.seekTo(currentPosition + const Duration(seconds: 10));
                        },
                      ),
                    ],
                  ),
                ],
              )
            : const CircularProgressIndicator(), // في حالة التحميل
      ),
    );
  }
}
