import 'package:dollar_app/features/main/feeds/widgets/feeds_attachment_widget.dart';
import 'package:dollar_app/features/main/polls/provider/get_polls_provider.dart';
import 'package:dollar_app/features/main/polls/provider/stake_videos_notifier.dart';
import 'package:dollar_app/features/main/polls/provider/voted_videos_notifier.dart';
import 'package:dollar_app/features/main/polls/widgets/stake_bootom_sheet.dart';
import 'package:dollar_app/features/shared/widgets/dialog_method.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:dollar_app/features/main/polls/widgets/vote_pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PollsViewWidgets extends ConsumerStatefulWidget {
  const PollsViewWidgets({super.key});

  @override
  ConsumerState<PollsViewWidgets> createState() => _HomeArtistWidgetState();
}

class _HomeArtistWidgetState extends ConsumerState<PollsViewWidgets> {
  Set<String> votedVideos = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getPollsProvider.notifier).displayPolls(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(getPollsProvider);
    final stakedVideos = ref.watch(stakeVideoNotifierProvider);
    final votedVideos = ref.watch(votedVideosProvider);

    return model.when(
      data: (data) {
        return data.isEmpty
            ? Center(
                child: Text(
                  "No data to display",
                  style: GoogleFonts.lato(fontSize: 14.sp),
                ),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final artist = data[index].video;
                  final isStaked = stakedVideos.containsKey(artist!.id!);
                  final position = stakedVideos[artist.id!];
                  final isVoted = votedVideos.contains(artist.id!);
                  return Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: artist.artist?.avatar != null
                                      ? NetworkImage(artist.artist?.avatar)
                                      : null,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${artist.artist?.firstName} ${artist.artist?.lastName}",
                                      style: GoogleFonts.lato(fontSize: 12.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              artist.title ?? '',
                              style: GoogleFonts.lato(fontSize: 10.sp),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        ),
                        FeedsAttachmentWidget(file: artist.videoUrl!),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23.w),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  diolagMethod(
                                    context,
                                    child: VotePopupWidget(postId: artist.id!),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: isVoted
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey),
                                  child: Text(
                                    isVoted ? 'Unvote' : 'Vote',
                                    style: GoogleFonts.lato(
                                        fontSize: 10.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                 
                                  showStakeBottomSheet(context, artist.id!);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: isStaked
                                        ? Colors.green
                                        : Colors.green.shade300,
                                  ),
                                  child: Center(
                                    child: Text(
                                      isStaked ? 'Staked ($position)' : 'Stake',
                                      style: GoogleFonts.lato(
                                          fontSize: 10.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              if (artist.stakeCount! > 0)
                                Text(
                                  artist.stakeCount.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
      },
      error: (e, s) {
        return Center(
            child: Text(
          e.toString(),
          style: GoogleFonts.lato(),
        ));
      },
      loading: () => const ShimmerWidget(
        layoutType: LayoutType.howVideo,
      ),
    );
  }
}
