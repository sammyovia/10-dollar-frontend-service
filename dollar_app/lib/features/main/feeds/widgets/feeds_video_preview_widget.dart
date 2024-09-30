import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedsVideoPreview extends StatefulWidget {
  final String file;

  const FeedsVideoPreview({super.key, required this.file});

  @override
  State<FeedsVideoPreview> createState() => _FeedsVideoPreviewState();
}

class _FeedsVideoPreviewState extends State<FeedsVideoPreview> {
  late CustomVideoPlayerController _customVideoPlayerController;
  bool _isVideoInitialized = false;

  void _initializeVideoPlayer() {
    VideoPlayerController videoplayerController =
        VideoPlayerController.contentUri(Uri.parse(widget.file))
          ..initialize().then((_) {
            setState(() {
              _isVideoInitialized = true;
            });
          });

    _customVideoPlayerController = CustomVideoPlayerController(
      customVideoPlayerSettings: const CustomVideoPlayerSettings(),
      context: context,
      videoPlayerController: videoplayerController,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        // color: Colors.grey.shade100,
      ),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Video Player
          if (_isVideoInitialized)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CustomVideoPlayer(
                customVideoPlayerController: _customVideoPlayerController,
              ),
            ),
          // Loading Indicator
          if (!_isVideoInitialized)
            Container(

              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: SizedBox(
                  height: 30.h,
                  width: 30.h,
                  child: const CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          // Play Button (optional)
          if (_isVideoInitialized)
            Positioned(
              child: IconButton(
                icon: Icon(
                  _customVideoPlayerController
                          .videoPlayerController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: () {
                  setState(() {
                    _customVideoPlayerController
                            .videoPlayerController.value.isPlaying
                        ? _customVideoPlayerController.videoPlayerController
                            .pause()
                        : _customVideoPlayerController.videoPlayerController
                            .play();
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
