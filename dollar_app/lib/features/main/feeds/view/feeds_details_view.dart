import 'package:dollar_app/features/auth/view/otp_view.dart';
import 'package:dollar_app/features/main/feeds/providers/feed_details_provider.dart';
import 'package:dollar_app/features/main/feeds/providers/like_count_provider.dart';
import 'package:dollar_app/features/main/feeds/widgets/comment_box.dart';
import 'package:dollar_app/features/main/feeds/widgets/feeds_attachment_widget.dart';
import 'package:dollar_app/features/shared/widgets/app_bottom_sheet.dart';
import 'package:dollar_app/features/shared/widgets/music_loader.dart';
import 'package:dollar_app/services/date_manipulation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class FeedsDetailsView extends ConsumerStatefulWidget {
  const FeedsDetailsView({super.key, required this.postId});
  final String postId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeedsDetailsViewState();
}

class _FeedsDetailsViewState extends ConsumerState<FeedsDetailsView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getFeedsDetailsProvider.notifier).getFeeds(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final feedDetails = ref.watch(getFeedsDetailsProvider);
    return Scaffold(
        appBar: const CustomAppBar(
          title: SizedBox.shrink(),
          elevation: 4,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: feedDetails.when(
                    data: (data) {
                      final details = data.data!;
                      final isLiked =
                          DataManipulation.likedFeeds[details.id] ?? false;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: details.user?.avatar != null
                                    ? NetworkImage(data.data?.user?.avatar)
                                    : null,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${details.user?.firstName} ${details.user?.lastName}'),
                                  Text(details.user?.role ?? ''),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(details.content ?? ''),
                          SizedBox(
                            height: 8.h,
                          ),
                          if (details.attachment != null &&
                              details.attachment!.isNotEmpty)
                            FeedsAttachmentWidget(
                              file: details.attachment!,
                              height: 200.h,
                            ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AppBottomSheet.showBottomSheet(
                                      isDismissible: true,
                                      context,
                                      child: CommentBox(
                                        postId: details.id!,
                                      ));
                                },
                                child: Icon(
                                  IconlyBold.chat,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                details.commentCount.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  DataManipulation.toggleLike(
                                      details.id!, details.likeCount!);
                                  ref
                                      .read(likeCountProvider.notifier)
                                      .likeComment(details.id!);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: isLiked
                                      ? Colors.red
                                      : Colors.grey.shade200,
                                  size: 20.r,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                isLiked
                                    ? '${details.likeCount! + 1}'
                                    : details.likeCount.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const Text('Comments'),
                          CommentBox(
                            postId: details.id!,
                            showBottomSheet: false,
                          )
                        ],
                      );
                    },
                    error: (e, s) {
                      return Text(e.toString());
                    },
                    loading: () => const AppLoader()))));
  }
}
