import 'dart:async';
import 'dart:developer';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyEmailProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> verifyEmail(context,
      {required String code, required String email}) async {
    try {
      state = const AsyncLoading();
      final token = TokenStorage();
      final userId = await token.getUserId();
      log(userId.toString());
      final res = await ref.read(networkProvider).postRequest(
          path: '/auth/email-verification',
          body: {"userId": userId, "otpCode": code, "type": "VERIFY_EMAIL"});
      log(res.toString());
      if (res['success'] == true) {
        ref.read(router).go("${AppRoutes.setUp}/$email");
      }

      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  Future<void> resendCode(context, {required String email}) async {
    try {
      state = const AsyncLoading();
      final token = TokenStorage();
      final userId = await token.getUserId();
      log(userId.toString());
      final res = await ref.read(networkProvider).postRequest(
          path: '/auth/resend-code',
          body: {"email": email, "type": "VERIFY_EMAIL"});
      log(res.toString());
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

final verifyEmailProvider =
    AsyncNotifierProvider<VerifyEmailProvider, Map<String, dynamic>>(
        VerifyEmailProvider.new);
