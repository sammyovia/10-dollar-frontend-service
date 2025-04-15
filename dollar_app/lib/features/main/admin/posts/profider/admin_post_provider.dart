import 'dart:async';
import 'dart:developer';

import 'package:dollar_app/features/main/feeds/model/feeds_model.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminPostProvider extends AsyncNotifier<List<FeedModelData>> {
  Future<List<FeedModelData>> getFeeds() async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).getRequest(path: '/posts');
      final feeds = FeedsModel.fromJson(response).feedModelData;
      final adminFeeds =
          feeds.where((feed) => feed.user.role == "ADMIN").toList();
      log(adminFeeds.toString());

      return adminFeeds;
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

final getAdminFeeds =
    AsyncNotifierProvider<AdminPostProvider, List<FeedModelData>>(
        AdminPostProvider.new);
