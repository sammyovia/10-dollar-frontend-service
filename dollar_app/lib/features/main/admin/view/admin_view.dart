import 'package:dollar_app/features/main/videos/provider/get_videos_provider.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/features/shared/widgets/home_artist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class AdminView extends ConsumerStatefulWidget {
  const AdminView({super.key});

  @override
  ConsumerState<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends ConsumerState<AdminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        elevation: 5,
        title: Text('Admin'),
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
                      showVote: false,
                      showPublished: true,
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
