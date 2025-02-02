import 'dart:async';
import 'dart:developer';

import 'package:dollar_app/features/main/polls/provider/get_polls_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local_votes_provider.dart';

class VoteProvider extends AsyncNotifier<Map<String, dynamic>> {
  // Handles the voting process for a video
  Future<void> voteVideo(context,
      {required String videoId, required String userId}) async {
    try {
      // Set the state to loading while the network request is being made
      state = const AsyncLoading();

      // Send the vote request to the server
      final response = await ref
          .read(networkProvider)
          .putRequest(path: '/videos/vote', body: {"videoId": videoId});

      log(response.toString());

      // Fetch the locally persisted votes for the user
      final votedVideos = await ref
          .read(voteNotifierProvider.notifier)
          .loadVotes(userId: userId);

      // Check if the videoId already exists in the local storage
      if (votedVideos.contains(videoId)) {
        // If it exists, remove it from local storage
        await ref
            .read(voteNotifierProvider.notifier)
            .removeVote(videoId: videoId, userId: userId);
      } else {
        // If it doesn't exist, add it to local storage
        await ref
            .read(voteNotifierProvider.notifier)
            .saveVote(videoId: videoId, userId: userId);
      }

      // Invalidate any cached data related to polls after a successful vote
      ref.invalidate(getPollsProvider);

      // Update the state with the response data
      state = AsyncData(response);

      // Close the voting modal or page
      Navigator.pop(context);

      // Show a success toast to notify the user of the successful vote
      Toast.showSuccessToast(context, response['message']);
    } catch (e) {
      // Handle any errors during the voting process
      state = AsyncValue.error(e, StackTrace.current);
      log(e.toString());

      // Show an error toast to notify the user
      Toast.showErrorToast(context, e.toString());
    }
  }

  // Override the build method to initialize with an empty map
  @override
  FutureOr<Map<String, dynamic>> build() {
    return {};
  }
}

// Define the provider using AsyncNotifierProvider for asynchronous state management
final voteProvider =
AsyncNotifierProvider<VoteProvider, Map<String, dynamic>>(VoteProvider.new);

