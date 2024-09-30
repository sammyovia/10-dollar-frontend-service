import 'package:dollar_app/features/main/feeds/providers/get_feeds_provider.dart';
import 'package:dollar_app/features/main/feeds/providers/like_count_provider.dart';
import 'package:dollar_app/features/main/feeds/widgets/comment_box.dart';
import 'package:dollar_app/features/main/feeds/widgets/feeds_attachment_widget.dart';
import 'package:dollar_app/features/shared/widgets/app_bottom_sheet.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedsWidget extends ConsumerStatefulWidget {
  const FeedsWidget({
    super.key,
  });

  @override
  ConsumerState<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends ConsumerState<FeedsWidget> {
  final Map<String, bool> likedFeeds =
      {}; // To track liked state using UUID as key
  final Map<String, int> likedCounts = {}; //
  @override
  void initState() {
    super.initState();
  }

  Future<void> _toggleLike(String feedId, int initialLikeCount) async {
    final prefs = await SharedPreferences.getInstance();

    final isLiked = likedFeeds[feedId] ?? false;
    likedFeeds[feedId] = !isLiked;

    if (likedFeeds[feedId]!) {
      likedCounts[feedId] = (likedCounts[feedId] ?? initialLikeCount) + 1;
    } else {
      likedCounts[feedId] = (likedCounts[feedId] ?? initialLikeCount) - 1;
    }

    await prefs.setBool('like_$feedId', likedFeeds[feedId]!);
    await prefs.setInt('like_count_$feedId', likedCounts[feedId]!);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(getFeedsProvider);
    return model.when(
      data: (data) {
        return data.isEmpty
            ? const Center(
                child: Text('No Feeds to display'),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final feed = data[index];
                  final isLiked = likedFeeds[feed.id] ?? false;

                  return Container(
                    margin: EdgeInsets.only(bottom: 20.0.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: feed.user.avatar != null
                                  ? NetworkImage(feed.user.avatar!)
                                  : null,
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${feed.user.firstName ?? 'new'} ${feed.user.lastName ?? 'user'}',
                                  style: GoogleFonts.lato(fontSize: 12.sp),
                                ),
                                Text(
                                  feed.user.role,
                                  style: GoogleFonts.lato(fontSize: 10.sp),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go('/feeds/feedDetails/${feed.id}');
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23.0),
                                  child: Text(
                                    feed.content,
                                    style: GoogleFonts.lato(fontSize: 10.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                if (feed.attachment != null &&
                                    feed.attachment!.isNotEmpty)
                                  FeedsAttachmentWidget(file: feed.attachment!),
                                SizedBox(
                                  height: 5.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AppBottomSheet.showBottomSheet(
                                      isDismissible: true,
                                      context,
                                      child: CommentBox(
                                        postId: feed.id,
                                      ));
                                },
                                child: Icon(
                                  Icons.comment_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 17.r,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                feed.commentCount.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _toggleLike(feed.id, feed.likeCount);
                                  ref
                                      .read(likeCountProvider.notifier)
                                      .likeComment(feed.id);
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
                              Text(
                                isLiked
                                    ? '${feed.likeCount + 1}'
                                    : feed.likeCount.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 12.sp,
                                ),
                              ),
                              const Spacer(),
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
        return Text(e.toString());
      },
      loading: () => const ShimmerWidget(
        layoutType: LayoutType.howVideo,
      ),
    );
  }
}
