import 'package:timeago/timeago.dart' as timeago;

class DataManipulation {
  static Map<String, bool> likedFeeds = {};
  static Map<String, int> likedCounts = {}; //
  static String timeAgo(String date) {
    return timeago.format(DateTime.parse(date));
  }

 static Future<void> toggleLike(String feedId, int initialLikeCount) async {

    final isLiked = likedFeeds[feedId] ?? false;
    likedFeeds[feedId] = !isLiked;

    if (likedFeeds[feedId]!) {
      likedCounts[feedId] = (likedCounts[feedId] ?? initialLikeCount) + 1;
    } else {
      likedCounts[feedId] = (likedCounts[feedId] ?? initialLikeCount) - 1;
    }
  }
}
