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
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          Icon(
            prefixIcon,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            title,
            style: GoogleFonts.lato(fontSize: 14.sp),
          ),
          const Spacer(),
          if (suffixIcon != null)
            Icon(
              suffixIcon,
              color: Theme.of(context).primaryColor,
            )
        ]),
      ),
    );
  }
}
