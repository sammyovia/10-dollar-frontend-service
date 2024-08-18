import 'dart:async';

import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> login(context,
      {required String email, required String password}) async {
    try {
      final token = TokenStorage();
      state = const AsyncLoading();
      final res = await ref.read(networkProvider).postRequest(
          path: '/auth/login', body: {"email": email, "password": password});
      token.saveTokens(res['data']['accessToken'], res['data']['refreshToken']);
      ref.read(router).go(AppRoutes.home);
      state = AsyncData(res);
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

final loginProvider =
    AsyncNotifierProvider<LoginProvider, Map<String, dynamic>>(
        LoginProvider.new);
