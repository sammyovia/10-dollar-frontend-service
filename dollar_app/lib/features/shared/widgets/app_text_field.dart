import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.labelText,
      required this.errorText,
      required this.hintText,
      this.icon,
      this.controller,
      this.onchaged,
      this.keybordType,
      this.suffix,
      this.obscureText = false,
      this.readOnly = false});
  final String labelText;
  final String errorText;
  final String hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final Function(String?)? onchaged;
  final TextInputType? keybordType;
  final Widget? suffix;
  final bool obscureText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: isDark ? Theme.of(context).dividerColor : null),
            ),
            Text(
              errorText,
              style:
                  GoogleFonts.lato(fontSize: 10.sp, color: Colors.red.shade900),
            )
          ],
        ),
        SizedBox(height: 5.h),
        Container(
          height: 35.h,
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
              borderRadius: BorderRadius.circular(15)),
          width: double.infinity,
          child: TextField(
            readOnly: readOnly,
            obscureText: obscureText,
            keyboardType: keybordType,
            onChanged: onchaged,
            controller: controller,
            cursorColor: Theme.of(context).dividerColor,
            style: GoogleFonts.lato(
                fontSize: 12.sp, color: isDark ? Theme.of(context).dividerColor : null),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                isDense: true,
                filled: false,
                prefixIcon: Icon(
                  icon,
                  size: 17.r,
                  color: Theme.of(context).dividerColor,
                ),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: GoogleFonts.lato(
                    fontSize: 12.sp, color: Theme.of(context).dividerColor),
                suffixIcon: suffix),
          ),
        ),
      ],
    );
  }
}
