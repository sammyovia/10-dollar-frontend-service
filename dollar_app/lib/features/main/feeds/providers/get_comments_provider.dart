import 'dart:async';

import 'package:dollar_app/features/main/feeds/model/comment_model.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetCommentsProvider extends AsyncNotifier<List<CommentModelData>> {
  Future<void> getComments(String postId) async {
    try {
      state = const AsyncLoading();
      final response = await ref
          .read(networkProvider)
          .getRequest(path: '/posts/$postId/comments');
      final feeds = CommentModel.fromJson(response).data;
      state = AsyncData(feeds);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> displayComent(String postId) async {
    try {
      final response = await ref
          .read(networkProvider)
          .getRequest(path: '/posts/$postId/comments');
      final feeds = CommentModel.fromJson(response).data;
      state = AsyncData(feeds);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  FutureOr<List<CommentModelData>> build() {
    return [];
  }
}

final getCommentProvider =
    AsyncNotifierProvider<GetCommentsProvider, List<CommentModelData>>(
        GetCommentsProvider.new);
