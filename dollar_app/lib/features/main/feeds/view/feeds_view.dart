import 'package:dollar_app/features/main/feeds/providers/get_feeds_provider.dart';
import 'package:dollar_app/features/main/feeds/widgets/feeds_widget.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

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
        },
        child: SingleChildScrollView(
         
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Feed",
                style: GoogleFonts.lato(fontSize: 16.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                color: Theme.of(context).dividerColor,
                //thickness: 2,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/feeds/new');
                    },
                    child: SizedBox(
                        width: 250.w,
                        child: TextField(
                          enabled: false,
                          readOnly: true,
                          decoration: InputDecoration(
                              isDense: true,
                              fillColor: Theme.of(context).scaffoldBackgroundColor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isDark
                                          ? const Color(0xFFB2DFDF)
                                          : const Color(0xFF5AA3A3)),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isDark
                                          ? const Color(0xFFB2DFDF)
                                          : const Color(0xFF5AA3A3)),
                                  borderRadius: BorderRadius.circular(50)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isDark
                                          ? const Color(0xFFB2DFDF)
                                          : const Color(0xFF5AA3A3)),
                                  borderRadius: BorderRadius.circular(50)),
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
                height: 15.h,
              ),
              Padding(
                 padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const FeedsWidget(),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class PinnedInfoWidget extends StatelessWidget {
  const PinnedInfoWidget({super.key, this.onClose});
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        height: 100.h,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              IconlyBold.volume_up,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
                width: 200.w,
                child: Text(
                  "Hello All your winnings have been paid to your account",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold),
                )),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                IconlyBold.close_square,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
