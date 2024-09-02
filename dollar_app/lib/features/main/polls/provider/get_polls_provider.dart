import 'dart:async';

import 'package:dollar_app/features/main/polls/model/polls_video_model.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetPollsProvider extends AsyncNotifier<List<PollsVideoModelData>> {
  Future<List<PollsVideoModelData>> getFeeds() async {
    final response = await ref.read(networkProvider).getRequest(path: '/polls');
    final videos = PollsVideoModel.fromJson(response).data;

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
  FutureOr<List<PollsVideoModelData>> build() {
    state = const AsyncLoading();
    return getFeeds();
  }
}

final getPollsProvider =
    AsyncNotifierProvider<GetPollsProvider, List<PollsVideoModelData>>(
        GetPollsProvider.new);
