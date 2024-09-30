import 'dart:async';

import 'package:dollar_app/features/main/polls/model/polls_video_model.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetPollsProvider extends AsyncNotifier<List<Data>> {
  Future<List<Data>> getPolls() async {
    final response = await ref.read(networkProvider).getRequest(path: '/polls');
    final videos = PollsVideoModel.fromJson(response).data ?? [];

    return videos;
  }

  Future<void> displayPolls(context,) async {
    try {
      state = const AsyncLoading();
      final res = await getPolls();
      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  FutureOr<List<Data>> build() {
    state = const AsyncLoading();
    return getPolls();
  }
}

final getPollsProvider =
    AsyncNotifierProvider<GetPollsProvider, List<Data>>(
        GetPollsProvider.new);
