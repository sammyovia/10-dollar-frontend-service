import 'dart:async';

import 'package:dollar_app/features/main/videos/model/video_model.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetVideosProvider extends AsyncNotifier<List<VideoModelData>> {
  Future<List<VideoModelData>> getFeeds() async {
    final response =
        await ref.read(networkProvider).getRequest(path: '/videos');
    final videos = VideoModel.fromJson(response).data;

    return videos;
  }

  Future<void> displayFeeds(context) async {
    try {
      state = const AsyncLoading();
      final res = await getFeeds();
      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  FutureOr<List<VideoModelData>> build() {
    state = const AsyncLoading();
    return getFeeds();
  }
}

final getVideosProvider =
    AsyncNotifierProvider<GetVideosProvider, List<VideoModelData>>(
        GetVideosProvider.new);
