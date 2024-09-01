import 'package:dollar_app/features/main/home/model/top_artist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:async';

import 'package:dollar_app/services/network/network_repository.dart';

class TopArtistProvider extends AsyncNotifier<List<TopArtistModelData>> {
  Future<List<TopArtistModelData>> getFeeds() async {
    state = const AsyncLoading();
    final response =
        await ref.read(networkProvider).getRequest(path: '/home/artists');
    final feeds = TopArtistModel.fromJson(response).data;

    return feeds;
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
  FutureOr<List<TopArtistModelData>> build() {
    return getFeeds();
  }
}

final topArtistProvider =
    AsyncNotifierProvider<TopArtistProvider, List<TopArtistModelData>>(
        TopArtistProvider.new);
