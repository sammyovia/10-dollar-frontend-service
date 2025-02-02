import 'package:dollar_app/features/main/polls/provider/vote_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the StateNotifier to manage the voted videos
final votedVideosProvider =
    StateNotifierProvider<VotedVideosNotifier, Set<String>>((ref) {
  return VotedVideosNotifier();
});

class VotedVideosNotifier extends StateNotifier<Set<String>> {
  VotedVideosNotifier() : super({});

  // Load the voted videos from SharedPreferences
  Future<void> loadVotedVideos() async {
    state = await VoteService().getVotedVideos();
  }

  // Add a video to the voted list
  Future<void> saveVotedVideo(String videoId) async {
    await VoteService().saveVotedVideo(videoId);
    state = {...state, videoId};
  }

  // Remove a video from the voted list
  Future<void> removeVotedVideo(String videoId) async {
    await VoteService().removeVotedVideo(videoId);
    state = state..remove(videoId);
  }
}
