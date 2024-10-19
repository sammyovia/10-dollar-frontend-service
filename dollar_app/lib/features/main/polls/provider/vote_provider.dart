import 'dart:async';

import 'package:dollar_app/features/main/polls/provider/get_polls_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local_votes_provider.dart';

class VoteProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> voteVideo(context,
      {required String videoId, required String userId}) async {
    try {
      state = const AsyncLoading();

      final response = await ref
          .read(networkProvider)
          .putRequest(path: '/videos/vote', body: {"videoId": videoId});
      print(response);

      final votedVideos = await ref
          .read(voteNotifierProvider.notifier)
          .loadVotes(userId: userId);
      if (votedVideos.contains(videoId)) {
        await ref
            .read(voteNotifierProvider.notifier)
            .removeVote(videoId: videoId, userId: userId);
      } else {
        await ref
            .read(voteNotifierProvider.notifier)
            .saveVote(videoId: videoId, userId: userId);
      }

      ref.invalidate(getPollsProvider);
      state = AsyncData(response);
      Navigator.pop(context);
      Toast.showSuccessToast(context, response['message']);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    return {};
  }
}

final voteProvider =
    AsyncNotifierProvider<VoteProvider, Map<String, dynamic>>(VoteProvider.new);
