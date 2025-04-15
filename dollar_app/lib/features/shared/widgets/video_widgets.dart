import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget(
      {super.key, required this.video, this.height = 150, this.topPosition,
      this.bottomPosition});

  final String video;
  final double height;
  final double? topPosition;
  final double? bottomPosition;

  @override
  Widget build(BuildContext context) {
    return
    
     Stack(
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(video), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade300),
        ),
        Positioned(
          top: topPosition ?? 40.h,
          left: bottomPosition ?? 130.w,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
