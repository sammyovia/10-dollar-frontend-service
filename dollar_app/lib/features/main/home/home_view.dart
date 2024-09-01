import 'package:dollar_app/features/main/home/provider/top_artist_provider.dart';
import 'package:dollar_app/features/main/videos/provider/get_videos_provider.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/features/shared/widgets/home_artist_widget.dart';
import 'package:dollar_app/features/shared/widgets/top_artist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        showProfile: true,
        showSearch: true,
        showLeading: true,
        height: 70.h,
        title: const Text('Home'),
        centerTitle: false,
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(topArtistProvider.notifier).displayFeeds();
          ref.refresh(getVideosProvider.notifier).displayFeeds(context);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text(
                      "Top Voted Artist",
                      style: GoogleFonts.lato(fontSize: 16.sp),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Theme.of(context).dividerColor,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const TopArtistWidget()
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 2,
                color: Theme.of(context).dividerColor,
              ),
              const HomeArtistWidget()
            ],
          ),
        ),
      )),
    );
  }
}
