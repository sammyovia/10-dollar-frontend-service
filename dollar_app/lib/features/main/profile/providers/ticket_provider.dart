import 'dart:async';

import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> getTickets() async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).getRequest(path: '/tickets');

      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    state = const AsyncLoading();
    return ref.read(networkProvider).getRequest(path: '/tickets');
  }
}

final ticketProvider =
    AsyncNotifierProvider<TicketProvider, Map<String, dynamic>>(
        TicketProvider.new);
