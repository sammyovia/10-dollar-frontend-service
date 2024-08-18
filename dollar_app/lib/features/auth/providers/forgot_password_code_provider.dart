import 'dart:async';

import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordCodeProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> getCode(context, {required String email}) async {
    try {
      state = const AsyncLoading();
      final res = await ref
          .read(networkProvider)
          .postRequest(path: '/auth/forgot-password', body: {"email": email});

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

final forgotPasswordCodeProvider =
    AsyncNotifierProvider<ForgotPasswordCodeProvider, Map<String, dynamic>>(
        ForgotPasswordCodeProvider.new);
