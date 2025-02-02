import 'dart:async';
import 'dart:developer';

import 'package:dollar_app/features/main/admin/users/provider/user_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRoleProvider extends AutoDisposeAsyncNotifier<Map<String, dynamic>> {
  Future<void> changeUserRole(context,
      {required String id, required String newRole}) async {
    try {
      state = const AsyncLoading();
      final response = await ref.read(networkProvider).putRequest(
          path: '/users/role', body: {"userId": id, "role": newRole});
      log(response.toString());
      state = AsyncData(response);
      if (response['status'] == true) {
        ref.invalidate(userProvider);
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

final userRoleProvider =
    AutoDisposeAsyncNotifierProvider<UserRoleProvider, Map<String, dynamic>>(
        UserRoleProvider.new);
