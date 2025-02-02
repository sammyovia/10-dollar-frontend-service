import 'package:dollar_app/features/main/videos/provider/get_videos_provider.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/features/shared/widgets/home_artist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class VideosView extends ConsumerStatefulWidget {
  const VideosView({super.key});

  @override
  ConsumerState<VideosView> createState() => _FeedsViewState();
}

class _FeedsViewState extends ConsumerState<VideosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        elevation: 5,
        title: Text('Videos'),
        centerTitle: false,
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(getVideosProvider.notifier).displayFeeds(context);
        },
        child: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(getVideosProvider.notifier).displayFeeds(context);
          },
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeArtistWidget(
                      showDelete: true,
                      showShare: false,
                      showStake: false,
                      showLike: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(IconlyBold.upload),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          context.go('/profile/videos/upload');
        },
        label: const Text('Upload Video'),
      ),
    );
  }
}
