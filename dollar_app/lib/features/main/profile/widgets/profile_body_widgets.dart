import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget(
      {super.key,
      required this.prefixIcon,
      required this.title,
      this.suffixIcon,
      this.onClick});
  final IconData prefixIcon;
  final String title;
  final IconData? suffixIcon;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: isDark?Colors.grey.shade800: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          Icon(
            prefixIcon,
            size: 17.r,
            color: Theme.of(context).dividerColor,
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 12.sp),
          ),
          const Spacer(),
          if (suffixIcon != null)
            Icon(
              suffixIcon,
              size: 17.r,
              color: Theme.of(context).dividerColor,
            )
        ]),
      ),
    );
  }
}
