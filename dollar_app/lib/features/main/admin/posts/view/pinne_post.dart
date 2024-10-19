import 'package:dollar_app/features/main/admin/posts/profider/admin_post_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../feeds/providers/like_count_provider.dart';
import '../../../feeds/view/delete_post.dart';
import '../../../feeds/widgets/comment_box.dart';
import '../../../feeds/widgets/feeds_attachment_widget.dart';
import '../../../profile/providers/get_profile_provider.dart';

class PinnedInfoWidget extends ConsumerStatefulWidget {
  const PinnedInfoWidget({super.key, this.onClose});
  final VoidCallback? onClose;

  @override
  ConsumerState<PinnedInfoWidget> createState() => _PinnedInfoWidgetState();
}

class _PinnedInfoWidgetState extends ConsumerState<PinnedInfoWidget> {
  bool showDetails = false;

  void setDetails() {
    setState(() {
      showDetails = !showDetails;
    });
  }

  String _formatTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('d/M/y').format(dateTime);
  }

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
    final pinedPost = ref.watch(getAdminFeeds);
    final userRole = ref.watch(getProfileProvider).value?.role ?? "";
    final userId = ref.watch(getProfileProvider).value?.id ?? "";
    return pinedPost.when(
        data: (data) {
          return Column(
            children: [
              data.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No admin post at the moment",
                          style: GoogleFonts.lato(),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppPrimaryButton(
                          title: "Re fetch",
                          onPressed: () {
                            ref.read(getAdminFeeds.notifier).getFeeds();
                          },
                          enabled: true,
                          putIcon: false,
                          height: 35.h,
                          width: 150.w,
                        )
                      ],
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final post = data[index];
                        final isLiked = likedFeeds[post.id] ?? false;
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setDetails();
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      IconlyBold.volume_up,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          post.content.toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                            fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    GestureDetector(
                                      onTap: widget.onClose,
                                      child: Icon(
                                        IconlyBold.close_square,
                                        color: Theme.of(context).dividerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            showDetails
                                ? Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.h, horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage:
                                                  post.user.avatar != null
                                                      ? NetworkImage(
                                                          post.user.avatar!)
                                                      : null,
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              "${post.user.firstName} ${post.user.lastName}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            Text(
                                              _formatTime(
                                                  post.createdAt.toString()),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          post.content,
                                          textAlign: TextAlign.center,
                                          style:
                                              GoogleFonts.lato(fontSize: 10.sp),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        if (post.attachment != null &&
                                            post.attachment!.isNotEmpty)
                                          FeedsAttachmentWidget(
                                              file: post.attachment!),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 23.0),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  AppBottomSheet
                                                      .showBottomSheet(
                                                          isDismissible: true,
                                                          context,
                                                          child: CommentBox(
                                                            postId: post.id,
                                                          ));
                                                },
                                                child: Icon(
                                                  Icons.comment_rounded,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  size: 17.r,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                post.commentCount.toString(),
                                                style: GoogleFonts.lato(
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _toggleLike(
                                                      post.id, post.likeCount);
                                                  ref
                                                      .read(likeCountProvider
                                                          .notifier)
                                                      .likePost(post.id);
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
                                                    ? '${post.likeCount + 1}'
                                                    : post.likeCount.toString(),
                                                style: GoogleFonts.lato(
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                              const Spacer(),
                                              if (userRole == "ADMIN" ||
                                                  userId == post.user.id)
                                                IconButton(
                                                    onPressed: () {
                                                      AppBottomSheet
                                                          .showBottomSheet(
                                                              context,
                                                              child:
                                                                  DeletePostWidget(
                                                                      post:
                                                                          post));
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 17.r,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        );
                      }),
            ],
          );
        },
        error: (error, stack) {
          return Center(
            child: Text(
              'There was an error getting this info',
              style: GoogleFonts.lato(),
            ),
          );
        },
        loading: () => const CircularProgressIndicator());
  }
}
