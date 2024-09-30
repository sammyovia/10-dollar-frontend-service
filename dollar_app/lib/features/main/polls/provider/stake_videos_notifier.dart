import 'package:flutter_riverpod/flutter_riverpod.dart';

class StakedVideosNotifier extends StateNotifier<Map<String, dynamic>> {
  StakedVideosNotifier() : super({});

  final Set<String> availablePositions = {'first', 'second', 'third'};

  bool isVideoStaked(String videoId) {
    return state.containsKey(videoId);
  }

  String? getPositionForVideo(String videoId) {
    return state[videoId];
  }

  bool canStakeMore() {
    return state.length < 3;
  }

  bool isPositionAvailable(String position) {
    return !state.containsValue(position);
  }

  void stakeVideo(String videoId, String position) {
    if (canStakeMore()) {
      state = {...state, videoId: position};
    }
  }

  void unStakeVideo(String videoId) {
    final newState = {...state};
    newState.remove(videoId);
    state = newState;
  }

  List<Map<String, dynamic>> getStakedVideos() {
    return state.entries
        .map((entry) => {
              "videoId": entry.key,
              "position": entry.value.toUpperCase(),
            })
        .toList();
  }
}

final stakeVideoNotifierProvider =
    StateNotifierProvider<StakedVideosNotifier, Map<String, dynamic>>((ref) {
  return StakedVideosNotifier();
});
