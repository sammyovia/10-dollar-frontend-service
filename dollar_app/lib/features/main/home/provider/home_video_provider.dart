import 'dart:async';

import 'package:dollar_app/features/main/home/model/home_video_model.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeVideosProvider extends AsyncNotifier<List<Data>> {
  Future<List<Data>> getFeeds() async {
    final response =
        await ref.read(networkProvider).getRequest(path: '/home/videos');
    final videos =  HomeVideo.fromJson(response).data ?? [];

    return videos;
  }

  Future<void> displayFeeds(context, {bool pollsPage = false}) async {
    try {
      state = const AsyncLoading();
      final res = await getFeeds();
      if (pollsPage) {}
      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  FutureOr<List<Data>> build() {
    state = const AsyncLoading();
    return getFeeds();
  }
}

final getHomeVideosProvider =
    AsyncNotifierProvider<HomeVideosProvider, List<Data>>(
        HomeVideosProvider.new);
