import 'dart:async';

import 'package:dollar_app/features/main/videos/provider/get_videos_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeDeleteVideoProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> likeVideo(String postId) async {
    try {
      final res = await ref
          .read(networkProvider)
          .putRequest(path: '/videos/like', body: {"videoId": postId});

      if (res['status'] == true) {
        ref.read(getVideosProvider.notifier).getFeeds();
      }
      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> voteVideo(context, {required String postId}) async {
    try {
      final res = await ref
          .read(networkProvider)
          .putRequest(path: '/videos/vote', body: {"videoId": postId});
      print(res);

      if (res['status'] == true) {
        ref.read(getVideosProvider.notifier).getFeeds();
        Toast.showSuccessToast(context, 'Voting Successful');
        Navigator.pop(context);
      }
      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  Future<void> stakeVideo(context,
      {required int amount, required List<Map<String, dynamic>> videos}) async {
    try {
      state = const AsyncLoading();
      final res = await ref.read(networkProvider).postRequest(
          path: '/polls/stake', body: {"amount": amount, "videos": videos});
      print(res);

      if (res['status'] == true) {
        ref.read(getVideosProvider.notifier).getFeeds();
        Toast.showSuccessToast(context, 'Voting Successful');
        Navigator.pop(context);
      }
      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  Future<void> deleteVidoe(context, {required String postId}) async {
    try {
      state = const AsyncLoading();
      final res = await ref
          .read(networkProvider)
          .deleteRequest(path: '/videos/$postId');
      if (res['status'] == true) {
        ref.invalidate(getVideosProvider);
        Navigator.pop(context);
      }
      state = AsyncData(res);
      await future;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> publishVideo(context, {required String postId}) async {
    try {
      state = const AsyncLoading();
      final res = await ref
          .read(networkProvider)
          .postRequest(path: '/videos/publish', body: {"videoId": postId});
      if (res['status'] == true) {
        ref.invalidate(getVideosProvider);
        Navigator.pop(context);
      }
      state = AsyncData(res);
      await future;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    return {};
  }
}

final likeDeleteVideoProvider =
    AsyncNotifierProvider<LikeDeleteVideoProvider, Map<String, dynamic>>(
        LikeDeleteVideoProvider.new);
