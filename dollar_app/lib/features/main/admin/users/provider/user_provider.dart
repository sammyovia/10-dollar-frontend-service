import 'dart:async';

import 'package:dollar_app/features/main/admin/users/model/user.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends AsyncNotifier<List<UserDatum>> {
  List<UserDatum> _cachedUsers = [];
  Future<void> getUsers() async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).getRequest(path: '/users');
      final users = User.fromJson(response).data;
      _cachedUsers = users;
      state = AsyncData(_cachedUsers);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<List<UserDatum>> getUser() async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).getRequest(path: '/users');
      final users = User.fromJson(response).data;
      state = AsyncData(users);
      return users;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  void searchUsers(String query) {
    final filteredUsers = _cachedUsers
        .where(
          (user) =>
              user.firstName!.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
              user.lastName!.toLowerCase().contains(query.toLowerCase()) ||
              user.role!.toLowerCase().contains(query.toLowerCase()) ||
              user.chatStatus!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    state = AsyncData(filteredUsers); // Update the state with filtered users
  }

  @override
  FutureOr<List<UserDatum>> build() {
    state = const AsyncLoading();

    return getUser();
  }
}

final userProvider =
    AsyncNotifierProvider<UserProvider, List<UserDatum>>(UserProvider.new);
