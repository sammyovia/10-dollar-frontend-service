import 'dart:async';

import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeeklyWinningsProder extends AsyncNotifier<Map<String,dynamic>> {
  Future<Map<String,dynamic>> getWinnings() async {
    final response = await ref.read(networkProvider).getRequest(path: '/tickets/winning-value');

    print("winnings $response");

    return response;
  }

  Future<void> displayWinngs(context,) async {
    try {
      state = const AsyncLoading();
      final res = await getWinnings();
      state = AsyncData(res);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  FutureOr<Map<String,dynamic>> build() {
    state = const AsyncLoading();
    return getWinnings();
  }
}

final weeklyWinningsProder =
    AsyncNotifierProvider<WeeklyWinningsProder, Map<String,dynamic>>(
        WeeklyWinningsProder.new);
