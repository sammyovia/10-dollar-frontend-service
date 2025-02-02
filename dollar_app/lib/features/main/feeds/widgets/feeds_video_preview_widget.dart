import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedsVideoPreview extends StatefulWidget {
  final String file;
  final double? width;
  final double? height;

  const FeedsVideoPreview({super.key, required this.file, this.width, this.height});

  @override
  State<FeedsVideoPreview> createState() => _FeedsVideoPreviewState();
}

class _FeedsVideoPreviewState extends State<FeedsVideoPreview> {
  late CustomVideoPlayerController _customVideoPlayerController;
  bool _isVideoInitialized = false;

  void _initializeVideoPlayer() {
    VideoPlayerController videoplayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.file))
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
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Video Player
          if (_isVideoInitialized)
            SizedBox(
              width: double.infinity,
              height: 200.h,
              child: CustomVideoPlayer(
                customVideoPlayerController: _customVideoPlayerController,
              ),
            ),
          // Loading Indicator
          if (!_isVideoInitialized)
            Container(

              width:  double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,

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
