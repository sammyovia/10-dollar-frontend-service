import 'package:dollar_app/features/main/feeds/widgets/feeds_attachment_widget.dart';
import 'package:dollar_app/features/main/polls/provider/get_polls_provider.dart';
import 'package:dollar_app/features/main/videos/provider/get_videos_provider.dart';
import 'package:dollar_app/features/main/videos/provider/like_delete_video_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_bottom_sheet.dart';
import 'package:dollar_app/features/shared/widgets/delete_pop_up_widget.dart';
import 'package:dollar_app/features/shared/widgets/dialog_method.dart';
import 'package:dollar_app/features/shared/widgets/publish_pop_up_widget.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:dollar_app/features/shared/widgets/stake_widget/view/stake_widget.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/features/shared/widgets/vote_pop_up_widget.dart';
import 'package:dollar_app/services/date_manipulation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PollsViewWidgets extends ConsumerStatefulWidget {
  const PollsViewWidgets(
      {super.key,
      this.showDelete = false,
      this.showShare = true,
      this.canStake = false,
      this.showLike = true,
      this.showStake = true,
      this.showVote = false,
      this.showPublished = false,
      this.pollsPage = false});
  final bool showDelete;
  final bool showShare;
  final bool canStake;
  final bool showLike;
  final bool showStake;
  final bool showVote;
  final bool showPublished;
  final bool pollsPage;

  @override
  ConsumerState<PollsViewWidgets> createState() => _HomeArtistWidgetState();
}

class _HomeArtistWidgetState extends ConsumerState<PollsViewWidgets> {
  Set<String> votedVideos = {};

  Future<void> _saveVotedVideos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('votedVideos', votedVideos.toList());
  }

  Future<void> _toggleVote(context, String videoId) async {
    setState(() {
      if (votedVideos.contains(videoId)) {
        votedVideos.remove(videoId);
      } else {
        votedVideos.add(videoId);
      }
    });
    await _saveVotedVideos();
    // Call the vote/unvote API here
    // await ref.read(voteProvider.notifier).toggleVote(videoId);
    diolagMethod(
      context,
      child: VotePopupWidget(postId: videoId),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(getVideosProvider.notifier)
          .displayFeeds(context, pollsPage: widget.pollsPage);
      _loadVotedVideos();
    });
  }

  Future<void> _loadVotedVideos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      votedVideos = prefs.getStringList('votedVideos')?.toSet() ?? {};
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(getPollsProvider);
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
                  final isLiked =
                      DataManipulation.likedFeeds[artist?.id] ?? false;
                  final isVoted = votedVideos.contains(artist?.id);
                  return Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage: artist?.artist?.avatar !=
                                            null
                                        ? NetworkImage(artist?.artist?.avatar)
                                        : null,
                                  ),
                                  SizedBox(width: 8.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${artist?.artist?.firstName} ${artist?.artist?.lastName}",
                                        style:
                                            GoogleFonts.lato(fontSize: 12.sp),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                artist?.title ?? '',
                                style: GoogleFonts.lato(fontSize: 10.sp),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                            ],
                          ),
                        ),
                        FeedsAttachmentWidget(file: artist!.videoUrl!),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23.w),
                          child: Row(
                            children: [
                              if (widget.showPublished)
                                GestureDetector(
                                  onTap: () {
                                    diolagMethod(
                                      context,
                                      child: PublishPopupWidget(
                                          postId: artist.id!),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.green),
                                    child: Text(
                                      'Publish',
                                      style: GoogleFonts.lato(
                                          fontSize: 10.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: 3.w,
                              ),
                              if (widget.showVote)
                                GestureDetector(
                                  onTap: () {
                                    if (isVoted) {
                                      Toast.showErrorToast(context,
                                          "You have already voted for this video");
                                    } else {
                                      _toggleVote(context, artist.id!);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: isVoted
                                            ? Colors.green
                                            : Colors.grey),
                                    child: Text(
                                      'vote',
                                      style: GoogleFonts.lato(
                                          fontSize: 10.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: 10.w,
                              ),
                              if (widget.showStake)
                                GestureDetector(
                                  onTap: () {
                                    if (widget.canStake) {
                                      AppBottomSheet.showBottomSheet(context,
                                          child: const StakeWidget());
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.grey,
                                    ),
                                    child: Text(
                                      'stake',
                                      style: GoogleFonts.lato(
                                          fontSize: 10.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: 3.w,
                              ),
                              if (widget.showStake)
                                Text(
                                  artist.voteCount.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              SizedBox(
                                width: 10.w,
                              ),
                              if (widget.showLike)
                                GestureDetector(
                                  onTap: () {
                                    DataManipulation.toggleLike(
                                        artist.id!, artist.likeCount!);
                                    ref
                                        .read(likeDeleteVideoProvider.notifier)
                                        .likeVideo(artist.id!);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: isLiked
                                        ? Colors.red
                                        : Colors.grey.shade200,
                                    size: 17.r,
                                  ),
                                ),
                              SizedBox(
                                width: 3.w,
                              ),
                              if (widget.showLike)
                                Text(
                                  isLiked
                                      ? '${artist.likeCount! + 1}'
                                      : artist.likeCount.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              const Spacer(),
                              if (widget.showShare)
                                GestureDetector(
                                  child: Icon(
                                    Icons.share,
                                    size: 17.r,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              SizedBox(
                                width: 10.w,
                              ),
                              if (widget.showDelete)
                                GestureDetector(
                                  onTap: () {
                                    diolagMethod(context,
                                        child: DeletePopupWidget(
                                          postId: artist.id!,
                                          onPress: () {},
                                        ));
                                  },
                                  child: Icon(Icons.delete,
                                      size: 17.r, color: Colors.grey),
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
