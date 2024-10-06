import 'package:dollar_app/features/main/profile/providers/ticket_provider.dart';
import 'package:dollar_app/features/main/videos/provider/get_videos_provider.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StakeTicketsView extends ConsumerStatefulWidget {
  const StakeTicketsView({super.key});

  @override
  ConsumerState<StakeTicketsView> createState() => _FeedsViewState();
}

class _FeedsViewState extends ConsumerState<StakeTicketsView> {
  String _formatTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('d/M/y').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final tickets = ref.watch(ticketProvider);
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 5,
        title: Text(
          'Stakes',
          style:
              GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
          child: RefreshIndicator(
              onRefresh: () async {
                await ref
                    .refresh(getVideosProvider.notifier)
                    .displayFeeds(context);
              },
              child: tickets.when(
                data: (data) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.refresh(ticketProvider.notifier).getTickets();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: ListView.builder(
                          itemCount: data['data'].length,
                          itemBuilder: (context, index) {
                            final tick = data['data'][index];
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                context.go(
                                    '/profile/tickets/ticketDetails/${tick['id']}');
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25.r,
                                    backgroundImage: tick['user']['avatar'] !=
                                            null
                                        ? NetworkImage(tick['user']['avatar'])
                                        : null,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${tick['user']['firstName']} ${tick['user']['lastName']}",
                                        style:
                                            GoogleFonts.lato(fontSize: 14.sp),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        _formatTime(tick['createdAt']),
                                        style:
                                            GoogleFonts.lato(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    tick['code'].toString(),
                                    style: GoogleFonts.lato(fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 50.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          tick['status'].toString(),
                                          style: GoogleFonts.lato(
                                              fontSize: 10.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  );
                },
                error: (error, trace) {
                  return Text(
                    error.toString(),
                    style: GoogleFonts.lato(),
                  );
                },
                loading: () => const ShimmerWidget(
                  layoutType: LayoutType.howVideo,
                ),
              ))),
    );
  }
}
