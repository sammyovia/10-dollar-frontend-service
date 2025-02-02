import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthBottomText extends StatelessWidget {
  const AuthBottomText(
      {super.key,
      required this.title,
      required this.actionText,
      required this.onClick});
  final String title;
  final String actionText;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 12.sp
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        GestureDetector(
          onTap: onClick,
          child: Text(
            actionText,
            style: GoogleFonts.lato(
                fontWeight: FontWeight.w800,
                fontSize: 12.sp,
                color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}
