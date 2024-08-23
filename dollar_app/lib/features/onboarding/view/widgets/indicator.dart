import 'package:dollar_app/features/onboarding/provider/indicator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndicatorWidget extends ConsumerStatefulWidget {
  const IndicatorWidget({super.key});

  @override
  ConsumerState<IndicatorWidget> createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends ConsumerState<IndicatorWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(inidcatorProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          return Container(
            margin: EdgeInsets.only(right: 7.w),
            width: selectedIndex == index ? 33.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : const Color(0XFFD9D9D9),
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }
}
