import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.title,
    this.putIcon = true,
    this.color = Colors.red,
  });
  final String title;
  final bool putIcon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(color: Colors.white),
          ),
          SizedBox(
            width: 8.w,
          ),
          if (putIcon)
            const Icon(
              IconlyBold.play,
              color: Colors.white,
            )
        ],
      ),
    );
  }
}
