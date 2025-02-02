import 'package:shared_preferences/shared_preferences.dart';

class VoteService {
  // Save voted video ID
  Future<void> saveVotedVideo(String videoId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> votedVideos = prefs.getStringList('voted_videos') ?? [];
    if (!votedVideos.contains(videoId)) {
      votedVideos.add(videoId);
    }
    await prefs.setStringList('voted_videos', votedVideos);
  }

  // Remove voted video ID
  Future<void> removeVotedVideo(String videoId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> votedVideos = prefs.getStringList('voted_videos') ?? [];
    votedVideos.remove(videoId);
    await prefs.setStringList('voted_videos', votedVideos);
  }

  // Retrieve voted videos
  Future<Set<String>> getVotedVideos() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('voted_videos')?.toSet() ?? <String>{};
  }
}
