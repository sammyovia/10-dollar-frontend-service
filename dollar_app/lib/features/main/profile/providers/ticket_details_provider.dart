import 'dart:async';

import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketDetailsProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> getTicketDetails(String id) async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).getRequest(path: '/tickets/$id');

      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    state = const AsyncLoading();
    return {};
  }
}

final ticketDetailsProvider =
    AsyncNotifierProvider<TicketDetailsProvider, Map<String, dynamic>>(
        TicketDetailsProvider.new);
