import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';

class PostFeedsProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> postFeeds({
    required String content,
    required List<File> attachments,
  }) async {
    try {
      state = const AsyncLoading();

      FormData formData =
          FormData.fromMap({"content": content, "title": "hello"});

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
          .postRequest(path: '/posts', body: formData);
      if (response['status'] == true) {
        print(response);
        attachments.clear();
        state = AsyncData(response);
        ref.invalidateSelf();
        ref.read(router).pop();
      }
    } catch (e) {
      print(e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    return {};
  }
}

final postFeedsProvider =
    AsyncNotifierProvider<PostFeedsProvider, Map<String, dynamic>>(
        PostFeedsProvider.new);
