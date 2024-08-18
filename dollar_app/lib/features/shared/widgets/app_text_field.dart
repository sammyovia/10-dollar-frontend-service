import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.labelText,
    required this.errorText,
    required this.hintText,
    required this.icon,
    this.controller,
    this.onchaged,
    this.keybordType,
    this.suffix,
    this.obscureText = false,
  });
  final String labelText;
  final String errorText;
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final Function(String?)? onchaged;
  final TextInputType? keybordType;
  final Widget? suffix;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: Colors.black87),
            ),
            Text(
              errorText,
              style: GoogleFonts.redHatDisplay(
                  fontSize: 14.sp, color: Colors.red.shade900),
            )
          ],
        ),
        //SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFBDBDBD),
              ),
              borderRadius: BorderRadius.circular(15)),
          width: double.infinity,
          child: TextField(
            obscureText: obscureText,
            keyboardType: keybordType,
            onChanged: onchaged,
            controller: controller,
            cursorColor: const Color(0xFFBDBDBD),
            style: GoogleFonts.redHatDisplay(),
            decoration: InputDecoration(
                filled: false,
                prefixIcon: Icon(icon, color: Colors.black87),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: GoogleFonts.redHatDisplay(fontSize: 12.sp),
                suffixIcon: suffix),
          ),
        ),
      ],
    );
  }
}
