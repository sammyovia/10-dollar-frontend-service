import 'dart:async';
import 'dart:developer';

import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeeklyWinningsProder extends AsyncNotifier<Map<String, dynamic>> {
  Future<Map<String, dynamic>> getWinnings() async {
    final response = await ref
        .read(networkProvider)
        .getRequest(path: '/tickets/winning-value');

    return response;
  }

  Future<void> displayWinngs(
    context,
  ) async {
    try {
      state = const AsyncLoading();
      final res = await getWinnings();
      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    state = const AsyncLoading();
    return getWinnings();
  }
}

class SetWinningsProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> setWinning(
      {required BuildContext context, required num percentage}) async {
    try {
      state = const AsyncLoading();
      final response = await ref.read(networkProvider).postRequest(
          path: '/tickets/winning-percentage',
          body: {"percentage": percentage});
      if (context.mounted) {
        Toast.showSuccessToast(context, "Successful");
      }
      log(response.toString());
      state = AsyncData(response);
    } catch (e) {
      if (context.mounted) {
        Toast.showErrorToast(context, e.toString());
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    return {};
  }
}

final weeklyWinningsProder =
    AsyncNotifierProvider<WeeklyWinningsProder, Map<String, dynamic>>(
        WeeklyWinningsProder.new);
        final setWinningsProvider =
    AsyncNotifierProvider<SetWinningsProvider, Map<String, dynamic>>(
        SetWinningsProvider.new);
