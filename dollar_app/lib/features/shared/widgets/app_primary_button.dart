import 'package:dollar_app/features/shared/widgets/music_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton(
      {super.key,
      required this.title,
      this.putIcon = true,
      this.color = Colors.red,
      this.onPressed,
      this.width,
      this.height,
      this.isLoading = false,
      this.enabled = false,
      this.radius = 15});
  final String title;
  final bool putIcon;
  final Color color;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool enabled;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: enabled ? color : color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLoading ? "Loading..." : title,
              style: GoogleFonts.lato(color: Colors.white),
            ),
            SizedBox(
              width: 8.w,
            ),
            isLoading
                ? const MusicLoader()
                : putIcon
                    ? const Icon(
                        IconlyBold.play,
                        color: Colors.white,
                      )
                    : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
