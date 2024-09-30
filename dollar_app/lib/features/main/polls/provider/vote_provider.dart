import 'dart:async';

import 'package:dollar_app/features/main/polls/provider/get_polls_provider.dart';
import 'package:dollar_app/features/main/polls/provider/vote_service.dart';
import 'package:dollar_app/features/main/polls/provider/voted_videos_notifier.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoteProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> voteVideo(context, {required String videoId}) async {
    try {
      state = const AsyncLoading();

      final response = await ref
          .read(networkProvider)
          .putRequest(path: '/videos/vote', body: {"videoId": videoId});

      final votedVideos = await VoteService().getVotedVideos();
      if (votedVideos.contains(videoId)) {
        await ref.read(votedVideosProvider.notifier).removeVotedVideo(videoId);
      } else {
        await ref.read(votedVideosProvider.notifier).saveVotedVideo(videoId);
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
