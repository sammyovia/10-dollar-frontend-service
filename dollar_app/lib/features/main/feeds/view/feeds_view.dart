import 'package:dollar_app/features/main/admin/posts/profider/admin_post_provider.dart';
import 'package:dollar_app/features/main/feeds/providers/get_feeds_provider.dart';
import 'package:dollar_app/features/main/feeds/widgets/feeds_widget.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../admin/posts/view/pinne_post.dart';
import '../../profile/providers/get_profile_provider.dart';

class FeedsView extends ConsumerStatefulWidget {
  const FeedsView({super.key});

  @override
  ConsumerState<FeedsView> createState() => _FeedsViewState();
}

class _FeedsViewState extends ConsumerState<FeedsView> {
  bool isBannerVisible = true;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final image = ref.watch(getProfileProvider).value?.avatar;
    return Scaffold(
      appBar: CustomAppBar(
        showProfile: true,
        showSearch: true,
        showLeading: true,
        height: 70.h,
        centerTitle: false,
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(getFeedsProvider.notifier).getFeeds();
          await ref.refresh(getProfileProvider.notifier).getProfile();
          await ref.refresh(getAdminFeeds.notifier).getFeeds();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "Feed",
                  style: GoogleFonts.lato(fontSize: 16.sp),
                ),
              ),
              Divider(
                color: Theme.of(context).dividerColor,
                //thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage:
                                image != null ? NetworkImage(image) : null),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go('/feeds/new');
                          },
                          child: SizedBox(
                              width: 260.w,
                              child: TextField(
                                enabled: false,
                                readOnly: true,
                                decoration: InputDecoration(
                                    isDense: true,
                                    fillColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: isDark
                                                ? const Color(0xFFB2DFDF)
                                                : const Color(0xFF5AA3A3)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: isDark
                                                ? const Color(0xFFB2DFDF)
                                                : const Color(0xFF5AA3A3)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: isDark
                                                ? const Color(0xFFB2DFDF)
                                                : const Color(0xFF5AA3A3)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "What's Popping?"),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    if (isBannerVisible)
                      PinnedInfoWidget(
                        onClose: () {
                          setState(() {
                            isBannerVisible = false;
                          });
                        },
                      ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const FeedsWidget()
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
