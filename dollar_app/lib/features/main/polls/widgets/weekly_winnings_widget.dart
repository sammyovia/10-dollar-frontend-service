import 'package:dollar_app/features/main/polls/provider/weekly_winnings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WeeklyWinngsWidget extends ConsumerWidget {
  const WeeklyWinngsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(weeklyWinningsProder);
    return notifier.when(
        data: (data) {
          return Card(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              width: double.infinity,
              child: Column(children: [
                Text(
                  "Weekly Winnings",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
                Text(
                  "₦${data['data']['winningValue']}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.green),
                )
              ]),
            ),
          );
        },
        error: (e, s) {
          return const Text("");
        },
        loading: () => const LinearProgressIndicator(
              color: Colors.green,
            ));
  }
}
