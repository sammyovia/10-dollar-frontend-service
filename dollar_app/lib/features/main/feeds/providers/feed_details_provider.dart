import 'dart:async';

import 'package:dollar_app/features/main/feeds/model/feed_details_model.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetFeedDetailsPage extends StateNotifier<AsyncValue<FeedDetails>> {
  GetFeedDetailsPage(this.ref) : super(const AsyncLoading());

  final Ref ref;

  Future<FeedDetails> getFeeds(String id) async {
    state = const AsyncLoading();
    final response =
        await ref.read(networkProvider).getRequest(path: '/posts/$id');
    final feeds = FeedDetails.fromJson(response);
    state = AsyncData(feeds);

    return feeds;
  }


}

final getFeedsDetailsProvider =
    StateNotifierProvider<GetFeedDetailsPage, AsyncValue<FeedDetails>>(
        GetFeedDetailsPage.new);
