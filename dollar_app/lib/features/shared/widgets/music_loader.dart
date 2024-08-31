import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';

class MusicLoader extends StatelessWidget {
  const MusicLoader({
    super.key,
    this.strokeWidth = 2,
    this.color = Colors.white,
  });
  final double strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth,
        ),
        MiniMusicVisualizer(
          height: 15.h,
          width: 3.w,
          animate: true,
          color: Colors.white,
        ),
      ],
    );
  }
}

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
