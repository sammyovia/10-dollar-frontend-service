import 'dart:async';

import 'package:dollar_app/features/main/feeds/model/feeds_model.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetFeedsProvider extends AsyncNotifier<List<FeedModelData>> {
  Future<List<FeedModelData>> getFeeds() async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).getRequest(path: '/posts');
      final feeds = FeedsModel.fromJson(response).feedModelData;

      return feeds;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  Future<void> displayFeeds() async {
    try {
      state = const AsyncLoading();
      final res = await getFeeds();
      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  FutureOr<List<FeedModelData>> build() {
    return getFeeds();
  }
}

final getFeedsProvider =
    AsyncNotifierProvider<GetFeedsProvider, List<FeedModelData>>(
        GetFeedsProvider.new);
