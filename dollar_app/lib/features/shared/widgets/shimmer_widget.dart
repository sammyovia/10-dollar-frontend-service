import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerWidget(
      {super.key,
      this.width,
      this.height,
      this.layoutType = LayoutType.howVideo});
  final LayoutType layoutType;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define shimmer colors based on the theme mode
    final baseColor =
        isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5);
    final highlightColor =
        isDarkMode ? const Color(0xFF4A4A4A) : const Color(0xFFE0E0E0);

    return Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: _buildLayout(layoutType, width, height, baseColor));
  }

  Widget _buildLayout(
      LayoutType layoutType, double? width, double? height, Color baseColor) {
    switch (layoutType) {
      case LayoutType.howVideo:
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      width: 100.w,
                      height: 10.h,
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      width: 200.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8)),
                    )
                  ],
                ),
              );
            });
      case LayoutType.homeArtist:
        return Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: 100.w,
                    height: 20.h,
                    color: Colors.grey.shade300,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 20,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: 100.w,
                    height: 20.h,
                    color: Colors.grey.shade300,
                  )
                ],
              ),
            ),
          ],
        );
      default:
        return Container(
          width: width,
          height: height,
          color: baseColor,
        );
    }
  }
}

enum LayoutType { homeArtist, howVideo }
