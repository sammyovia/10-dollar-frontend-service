import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';

class UploadVideoProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> uploadVideo(
    context, {
    required String title,
    required List<File> attachments,
  }) async {
    try {
      state = const AsyncLoading();

      FormData formData = FormData.fromMap({"title": title});

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
          .postRequest(path: '/videos', body: formData);
      if (response['status'] == true) {
        state = AsyncData(response);
        ref.invalidateSelf();
        ref.read(router).pop();
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

final uploadVideoProvider =
    AsyncNotifierProvider<UploadVideoProvider, Map<String, dynamic>>(
        UploadVideoProvider.new);
