import 'package:dollar_app/features/shared/widgets/stake_widget/model/stake_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StakeHelper extends ChangeNotifier {
  final Map<int, StakePosition?> selectedPositions = {};
  final Map<StakePosition, int?> globalSelectedPositions = {};
  Set<SelectedVideo> selectedVideos = {};
  void handlePositionSelection(
      int videoIndex, StakePosition position, String id, String title) {
    if (selectedPositions[videoIndex] == position) {
      // Deselect
      selectedPositions.remove(videoIndex);
      globalSelectedPositions.remove(position);
      selectedVideos.remove(SelectedVideo(id, title));
    } else {
      // Select new position
      if (selectedPositions.containsKey(videoIndex)) {
        globalSelectedPositions.remove(selectedPositions[videoIndex]);
        selectedVideos.removeWhere((video) => video.id == id);
      }
      selectedPositions[videoIndex] = position;
      globalSelectedPositions[position] = videoIndex;
      selectedVideos.add(SelectedVideo(id, title));
    }

    notifyListeners();
  }

  bool isPositionGloballySelected(StakePosition position) {
    return globalSelectedPositions.containsKey(position);
  }

   List<Map<String, String>> convertSelectedVideosToList() {
    return selectedVideos
        .map((video) => {
              "videoId": video.id,
              "position": video.position.toUpperCase(),
            })
        .toList();
  }
}

enum StakePosition { first, second, third }

final stakeHelperProvider = ChangeNotifierProvider((ref) => StakeHelper());
