import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({super.key, this.activeColor});
  final Color? activeColor;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14.w,
      height: 14.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 7.w,
          height: 7.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.activeColor,
          ),
        ),
      ),
    );
  }
}
