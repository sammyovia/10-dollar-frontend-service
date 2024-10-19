import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dollar_app/features/main/feeds/providers/get_comments_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';

class PostCommentsProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> postComments(context,
      {required String content,
      required List<File> attachments,
      required String postId}) async {
    try {
      state = const AsyncLoading();

      FormData formData =
          FormData.fromMap({"content": content, "postId": postId});

      for (var file in attachments) {
        String fileName = file.path.split('/').last;
        String? mimeType = lookupMimeType(file.path);

        formData.files.add(
          MapEntry(
            'attachment',
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
              contentType:
                  DioMediaType.parse(mimeType ?? 'application/octect-stream'),
            ),
          ),
        );
      }

      final response = await ref
          .read(networkProvider)
          .postRequest(path: '/posts/comments', body: formData);
      if (response['status'] == true) {
        state = AsyncData(response);
        ref.read(getCommentProvider.notifier).displayComent(postId);
        ref.read(getCommentProvider.notifier).getComments(postId);
        attachments.clear();
      }
      await future;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    return {};
  }
}

final postCommentProvider =
    AsyncNotifierProvider<PostCommentsProvider, Map<String, dynamic>>(
        PostCommentsProvider.new);
