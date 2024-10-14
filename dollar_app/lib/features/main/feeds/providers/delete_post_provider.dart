import 'dart:async';
import 'dart:developer';

import 'package:dollar_app/features/main/feeds/providers/get_feeds_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeletePostProvider
    extends AutoDisposeAsyncNotifier<Map<String, dynamic>> {
  Future<void> deletePost(context,
      {required String id}) async {
    try {
      state = const AsyncLoading();
      final response = await ref.read(networkProvider).deleteRequest(
        path: '/posts/$id',
      );
      log(response.toString());
      state = AsyncData(response);
      if (response['status'] == true) {
        ref.invalidate(getFeedsProvider);
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

final deletePostProvider = AutoDisposeAsyncNotifierProvider<
    DeletePostProvider, Map<String, dynamic>>(DeletePostProvider.new);
