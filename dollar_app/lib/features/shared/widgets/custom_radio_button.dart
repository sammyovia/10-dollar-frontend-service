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
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 13.w,
          height: 13.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.activeColor,
          ),
        ),
      ),
    );
  }
}
