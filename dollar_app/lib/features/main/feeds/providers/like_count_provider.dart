import 'dart:async';

import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeCountProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> likeComment(String postId) async {
    await ref
        .read(networkProvider)
        .put('/posts/like', data: {"postId": postId});
  }

  Future<void> deleteComment(String postId) async {
    await ref.read(networkProvider).delete('/posts/comments/$postId');
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    return {};
  }
}

final likeCountProvider =
    AsyncNotifierProvider<LikeCountProvider, Map<String, dynamic>>(
        LikeCountProvider.new);
