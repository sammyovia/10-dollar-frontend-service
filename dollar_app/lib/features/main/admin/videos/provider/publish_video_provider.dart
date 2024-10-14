import 'dart:async';
import 'dart:developer';

import 'package:dollar_app/features/main/admin/videos/provider/video_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PublishVideoProvider
    extends AutoDisposeAsyncNotifier<Map<String, dynamic>> {
  Future<void> unPublishVideo(context, {required String id}) async {
    try {
      state = const AsyncLoading();
      final response = await ref
          .read(networkProvider)
          .postRequest(path: '/videos/unpublish', body: {"videoId": id});
      log(response.toString());
      state = AsyncData(response);
      if (response['status'] == true) {
        ref.invalidate(videoProvider);
        Toast.showSuccessToast(context, "Operation Successful");
        Navigator.pop(context);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  Future<void> publishVideo(context, {required String id}) async {
    try {
      state = const AsyncLoading();
      final response = await ref
          .read(networkProvider)
          .postRequest(path: '/videos/publish', body: {"videoId": id});
      log(response.toString());
      state = AsyncData(response);
      if (response['status'] == true) {
        ref.invalidate(videoProvider);
        Toast.showSuccessToast(context, "Operation Successful");
        Navigator.pop(context);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  Future<void> deleteVideo(context, {required String id}) async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).deleteRequest(path: '/videos/$id');
      log(response.toString());
      state = AsyncData(response);
      if (response['status'] == true) {
        ref.invalidate(videoProvider);
        Toast.showSuccessToast(context, "Operation Successful");
        Navigator.pop(context);
      }
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

final publishVideoProvider = AutoDisposeAsyncNotifierProvider<
    PublishVideoProvider, Map<String, dynamic>>(PublishVideoProvider.new);
