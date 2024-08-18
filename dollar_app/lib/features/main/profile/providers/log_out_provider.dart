import 'dart:async';

import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogOutProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> logout(context) async {
    try {
      final token = TokenStorage();
      state = const AsyncLoading();
      final res =
          await ref.read(networkProvider).getRequest(path: '/auth/logout');
      print(res);
      if (res['success'] == true) {
        Navigator.pop(context);
        ref.read(router).go(AppRoutes.login);
      }

      state = AsyncData(res);
      token.clearTokens();
      ref.invalidateSelf();
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

final logoutProvider =
    AsyncNotifierProvider<LogOutProvider, Map<String, dynamic>>(
        LogOutProvider.new);
