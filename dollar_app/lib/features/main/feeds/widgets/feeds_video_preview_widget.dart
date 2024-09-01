import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedsVideoPreview extends StatefulWidget {
  final String file;

  const FeedsVideoPreview({super.key, required this.file});

  @override
  State<FeedsVideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<FeedsVideoPreview> {
  late CustomVideoPlayerController _customVideoPlayerController;

  void _initializeVideoPlayer() {
    VideoPlayerController videoplayerController =
        VideoPlayerController.contentUri(Uri.parse(widget.file))
          ..initialize().then((value) {
            setState(() {});
          });

    _customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoplayerController);
  }

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _customVideoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey.shade100,
        ),
        width: double.infinity,
        height: 150.h,
        child: CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController),
      ),
    );
    // return Stack(
    //   children: [
    //     ClipRRect(
    //         borderRadius: const BorderRadius.all(Radius.circular(10)),
    //         child: CustomVideoPlayer(
    //             customVideoPlayerController: _customVideoPlayerController)),
    //     // Align(
    //     //   alignment: Alignment.bottomCenter,
    //     //   child:
    //     //       VideoProgressIndicator(_controller, allowScrubbing: true),
    //     // ),
    //     // Positioned(
    //     //   top: 40.h,
    //     //   left: 130.w,
    //     //   child: Container(
    //     //       padding: const EdgeInsets.all(8),
    //     //       decoration: BoxDecoration(
    //     //         color: Colors.black.withOpacity(0.5),
    //     //         shape: BoxShape.circle,
    //     //       ),
    //     //       child: IconButton(
    //     //         onPressed: () {
    //     //           setState(() {
    //     //             _controller.value.isPlaying
    //     //                 ? _controller.pause()
    //     //                 : _controller.play();
    //     //           });
    //     //         },
    //     //       //   icon: Icon(
    //     //       //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     //       //     color: Colors.white,
    //     //       //   ),
    //     //       // )),
    //     // ),
    //   ],
    // );
    // : Container(
    //     height: 80,
    //     width: 80,
    //     color: Colors.black,
    //     child: const Center(child: CircularProgressIndicator()),
    //   );
  }
}
