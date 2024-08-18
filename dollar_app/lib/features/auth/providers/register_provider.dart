import 'dart:async';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> register(context,
      {required String email, required String password}) async {
    try {
      state = const AsyncLoading();
      final res = await ref
          .read(networkProvider)
          .postRequest(path: '/auth/register',body: {"email":email,"password":password});
      ref.read(router).go(AppRoutes.login);
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
