

import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoteNotifier extends StateNotifier<Set<String>> {
  SharedPreferences? _prefs;

  VoteNotifier() : super({}) ;


  Future<String> loadVotes({required String userId}) async {
    log("loading votes >>>>>>>>>>>>");
    _prefs = await SharedPreferences.getInstance();
    final votes =  _prefs?.getString('votes_$userId') ?? [];
    log("$votes  Loaded for $userId<<<<<<");

    return votes.toString();
  }

  Future<void> saveVote({required String videoId,required String userId}) async {
    final updatedVotes = {...state}..add(videoId);
    state = updatedVotes;

    await _prefs?.setString('votes_$userId', videoId);
    log("voting $videoId for $userId");

  }

  Future<void> removeVote({ required String videoId, required String userId}) async {
    final updatedVotes = {...state}..remove(videoId);
    state = updatedVotes;
    await _prefs?.setString('votes_$userId', "");
  }

  Future<void> clearVotes(String userId) async {
    state = {};
    await _prefs?.remove('votes_$userId');
  }
}

final voteNotifierProvider = StateNotifierProvider<VoteNotifier, Set<String>>((ref) {
  return VoteNotifier();
});
