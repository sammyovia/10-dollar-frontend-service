import 'package:dollar_app/features/main/polls/provider/get_polls_provider.dart';
import 'package:dollar_app/features/main/polls/provider/weekly_winnings_provider.dart';
import 'package:dollar_app/features/main/polls/widgets/weekly_winnings_widget.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/features/main/polls/widgets/polls_view_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PollsView extends ConsumerStatefulWidget {
  const PollsView({super.key});

  @override
  ConsumerState<PollsView> createState() => _PollsViewState();
}

class _PollsViewState extends ConsumerState<PollsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const CustomAppBar(
        showLeading: true,
        showProfile: true,
        showSearch: true,
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(getPollsProvider.notifier).displayPolls(context);
          ref.refresh(weeklyWinningsProder.notifier).displayWinngs(context);
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  "Video Polls",
                  style: GoogleFonts.lato(fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
              const WeeklyWinngsWidget(),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.w),
                child: const PollsViewWidgets(),
              )
            ],
          ),
        ),
      )),
    );
  }
}


