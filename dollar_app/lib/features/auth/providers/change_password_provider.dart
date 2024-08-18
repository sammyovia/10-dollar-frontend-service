import 'dart:async';

import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> changePassword(
    context, {
    required String email,
    required String password,
    required String confirmPassword,
    required String code,
  }) async {
    try {
      state = const AsyncLoading();
      final data = {
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "resetCode": code.toString()
      };

      final res = await ref
          .read(networkProvider)
          .postRequest(path: '/auth/forgot-password-reset', body: data);

      state = AsyncData(res);
      if (res['success'] == true) {
        ref.read(router).pop();
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

final changePasswordProvider =
    AsyncNotifierProvider<ChangePasswordProvider, Map<String, dynamic>>(
        ChangePasswordProvider.new);
