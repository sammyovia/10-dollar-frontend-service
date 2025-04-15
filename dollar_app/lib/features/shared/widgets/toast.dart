import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Toast {
  static void showSuccessToast(
    BuildContext context,
    String message,
  ) {
    OverlayEntry overlayEntry;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: -20, //(MediaQuery.of(context).padding.top),
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 100 * value),
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0XFF073A45) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  bottom: BorderSide(
                    width: 5,
                    color: Color(0XFF2DCB30),
                  ),
                  right: BorderSide(
                    width: 3,
                    color: Color(0XFF2DCB30),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0XFF2DCB30).withValues(alpha:  0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SizedBox(
                width: (MediaQuery.of(context).size.width - 40 - 80).w,
                child: Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.redHatDisplay(
                      color: isDark ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 4), () {
      overlayEntry.remove();
    });
  }

  static void showErrorToast(
    BuildContext context,
    String message,
  ) {
    OverlayEntry overlayEntry;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: -30,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 100 * value),
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0XFF073A45) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  bottom: BorderSide(
                    width: 5,
                    color: Color(0XFFDC2B2B),
                  ),
                  right: BorderSide(
                    width: 3,
                    color: Color(0XFFDC2B2B),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0XFFDC2B2B).withValues(alpha:  0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SizedBox(
                width: (MediaQuery.of(context).size.width - 40 - 80).w,
                child: Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.redHatDisplay(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 12.sp),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
