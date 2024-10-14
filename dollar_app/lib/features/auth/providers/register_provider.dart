import 'dart:async';
import 'dart:developer';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> register(context,
      {required String email, required String password}) async {
    try {
      state = const AsyncLoading();
      final token = TokenStorage();
      final res = await ref.read(networkProvider).postRequest(
          path: '/auth/register', body: {"email": email, "password": password});
      log(res.toString());
      if (res['status'] == true) {
        token.saveTokens(
          accessToken: res['data']['accessToken'],
          refreshToken: res['data']['refreshToken'],
        );
        token.saveUserId(res['data']['id']);
        token.saveUserRegistered(true);
        token.saveUserEmail(res['data']['email'].toString());
        ref.read(router).go("${AppRoutes.verifyEmail}/${res['data']['email']}");
      }

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

final registerProvider =
    AsyncNotifierProvider<RegisterProvider, Map<String, dynamic>>(
        RegisterProvider.new);
