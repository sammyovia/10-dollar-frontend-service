import 'package:dollar_app/features/main/feeds/widgets/feeds_attachment_widget.dart';
import 'package:dollar_app/features/main/home/provider/home_video_provider.dart';
import 'package:dollar_app/features/shared/widgets/delete_pop_up_widget.dart';
import 'package:dollar_app/features/shared/widgets/dialog_method.dart';
import 'package:dollar_app/features/shared/widgets/publish_pop_up_widget.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:dollar_app/services/date_manipulation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeVideoProviderWidget extends ConsumerStatefulWidget {
  const HomeVideoProviderWidget(
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
  ConsumerState<HomeVideoProviderWidget> createState() =>
      _HomeArtistWidgetState();
}

class _HomeArtistWidgetState extends ConsumerState<HomeVideoProviderWidget> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(getHomeVideosProvider);
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
                  final artist = data[index];
                  final isLiked =
                      DataManipulation.likedFeeds[artist.id] ?? false;
                  return Container(
                    margin: EdgeInsets.only(bottom: 20.0.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: artist.artist?.avatar !=
                                          null
                                      ? NetworkImage(artist.artist?.avatar)
                                      : null,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${artist.artist?.firstName}  ${artist.artist?.lastName}",
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
                              artist.title ?? '',
                              style: GoogleFonts.lato(fontSize: 10.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        FeedsAttachmentWidget(file: artist.videoUrl ?? ''),
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
                                    child: PublishPopupWidget(
                                        postId: artist.id ?? ''),
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
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context).primaryColor,
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
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).primaryColor,
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
      ),
    );
  }
}
