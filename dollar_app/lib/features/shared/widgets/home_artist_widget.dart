import 'package:dollar_app/features/main/feeds/widgets/feeds_attachment_widget.dart';
import 'package:dollar_app/features/main/videos/provider/get_videos_provider.dart';
import 'package:dollar_app/features/main/videos/provider/like_delete_video_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_bottom_sheet.dart';
import 'package:dollar_app/features/shared/widgets/delete_pop_up_widget.dart';
import 'package:dollar_app/features/shared/widgets/dialog_method.dart';
import 'package:dollar_app/features/shared/widgets/publish_pop_up_widget.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:dollar_app/features/shared/widgets/stake_widget.dart';
import 'package:dollar_app/features/shared/widgets/vote_pop_up_widget.dart';
import 'package:dollar_app/services/date_manipulation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeArtistWidget extends ConsumerStatefulWidget {
  const HomeArtistWidget(
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
  ConsumerState<HomeArtistWidget> createState() => _HomeArtistWidgetState();
}

class _HomeArtistWidgetState extends ConsumerState<HomeArtistWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(getVideosProvider.notifier)
          .displayFeeds(context, pollsPage: widget.pollsPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(getVideosProvider);
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
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final artist = data[index];
                    final isLiked =
                        DataManipulation.likedFeeds[artist.id] ?? false;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // CircleAvatar(
                              //   backgroundColor: Colors.grey.shade300,
                              //   backgroundImage: NetworkImage(artist.profilePic),
                              // ),
                              SizedBox(width: 8.w),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   artist.fullName,
                                  //   style: GoogleFonts.lato(fontSize: 12.sp),
                                  // ),
                                  // Text(
                                  //   artist.position,
                                  //   style: GoogleFonts.lato(fontSize: 10.sp),
                                  // )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          if (artist.title != null)
                            Text(
                              artist.title ?? "",
                              style: GoogleFonts.lato(fontSize: 10.sp),
                            ),
                          SizedBox(
                            height: 8.h,
                          ),
                          FeedsAttachmentWidget(file: artist.videoUrl),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              if (widget.showPublished)
                                GestureDetector(
                                  onTap: () {
                                    diolagMethod(
                                      context,
                                      child:
                                          PublishPopupWidget(postId: artist.id),
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
                                    diolagMethod(
                                      context,
                                      child: VotePopupWidget(postId: artist.id),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.green),
                                    child: Text(
                                      'vote',
                                      style: GoogleFonts.lato(
                                          fontSize: 10.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: 3.w,
                              ),
                              if (widget.showVote)
                                Text(
                                  artist.voteCount.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
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
                                        artist.id, artist.likeCount);
                                    ref
                                        .read(likeDeleteVideoProvider.notifier)
                                        .likeVideo(artist.id);
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
                                      ? '${artist.likeCount + 1}'
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
                                          postId: artist.id,
                                          onPress: () {},
                                        ));
                                  },
                                  child: Icon(Icons.delete,
                                      size: 17.r, color: Colors.grey),
                                ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
        },
        error: (e, s) {
          return Text(e.toString());
        },
        loading: () => const ShimmerWidget( 
              layoutType: LayoutType.howVideo,
            ));
  }
}
