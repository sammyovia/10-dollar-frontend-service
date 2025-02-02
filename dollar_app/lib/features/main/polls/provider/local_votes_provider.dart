import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoteNotifier extends StateNotifier<Set<String>> {
  SharedPreferences? _prefs;

  VoteNotifier() : super({});

  // Initialize SharedPreferences lazily
  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Load votes as a list of video IDs
  Future<List<String>> loadVotes({required String userId}) async {
    await _initPrefs();
    log("Loading votes for $userId >>>>>>>>>>");
   final votes = _prefs?.getStringList('votes_$userId') ?? [];
    log("${votes.length} votes loaded for $userId <<<<<<");

    // Update state with the loaded votes
    state = votes.toSet();
    return votes;
  }

  // Save a vote (video ID) for the user
  Future<void> saveVote({required String videoId, required String userId}) async {
    await _initPrefs();
    final updatedVotes = {...state}..add(videoId); // Add the new vote
    state = updatedVotes;

    // Persist updated votes as a list
    await _prefs?.setStringList('votes_$userId', updatedVotes.toList());
    log("Voted for $videoId by $userId");
  }

  // Remove a vote (video ID) for the user
  Future<void> removeVote({required String videoId, required String userId}) async {
    await _initPrefs();
    final updatedVotes = {...state}..remove(videoId); // Remove the vote
    state = updatedVotes;

    // Persist updated votes as a list
    await _prefs?.setStringList('votes_$userId', updatedVotes.toList());
    log("Removed vote for $videoId by $userId");
  }

  // Clear all votes for the user
  Future<void> clearVotes(String userId) async {
    await _initPrefs();
    state = {}; // Clear state
    await _prefs?.remove('votes_$userId'); // Remove votes from storage
    log("Cleared all votes for $userId");
  }
}

// Riverpod provider for the VoteNotifier
final voteNotifierProvider = StateNotifierProvider<VoteNotifier, Set<String>>((ref) {
  return VoteNotifier();
});
