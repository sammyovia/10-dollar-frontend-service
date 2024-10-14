import 'dart:async';

import 'package:dollar_app/features/main/admin/videos/model/video.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoProvider extends AsyncNotifier<List<AdminVideoDatum>> {
  List<AdminVideoDatum> _cachedVideos = [];
  Future<void> getVideos() async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).getRequest(path: '/videos');
      final videos = AdminVideo.fromJson(response).data;
      _cachedVideos = videos;
      state = AsyncData(videos);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void searchVideos(String query) {
    final filteredUsers = _cachedVideos
        .where((video) =>
            video.title!.toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
            video.status!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    state = AsyncData(filteredUsers); // Update the state with filtered users
  }

  Future<List<AdminVideoDatum>> getVideo() async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).getRequest(path: '/videos');
      final videos = AdminVideo.fromJson(response).data;
      _cachedVideos = videos;
      state = AsyncData(videos);

      return videos;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  @override
  FutureOr<List<AdminVideoDatum>> build() {
    state = const AsyncLoading();

    return getVideo();
  }
}

final videoProvider =
    AsyncNotifierProvider<VideoProvider, List<AdminVideoDatum>>(
        VideoProvider.new);
