import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dollar_app/features/main/feeds/providers/get_feeds_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';

class PostFeedsProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> postFeeds(
    context, {
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
        ref.invalidateSelf();
        ref.invalidate(getFeedsProvider);
        Toast.showSuccessToast(context, 'Post Successful');
        Navigator.pop(context);
      }
      state = AsyncData(response);
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

final postFeedsProvider =
    AsyncNotifierProvider<PostFeedsProvider, Map<String, dynamic>>(
        PostFeedsProvider.new);
