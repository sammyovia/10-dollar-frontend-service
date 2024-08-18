import 'dart:async';

import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendAuthOtp extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> resendOtp(context,
      {required String email, String phone = "", int type = 0}) async {
    try {
      state = const AsyncLoading();
      final res = await ref
          .read(networkProvider)
          .postRequest(path: '/auth/resend-code', body: {
        "email": email,
        "phone": phone,
        "type": type,
      });

      state = AsyncData(res);
      Toast.showSuccessToast(context, "OTP has been resent to your mail");
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

final reseendOtpAuth =
    AsyncNotifierProvider<ResendAuthOtp, Map<String, dynamic>>(
        ResendAuthOtp.new);
