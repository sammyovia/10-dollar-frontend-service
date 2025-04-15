import 'dart:async';

import 'package:dollar_app/features/main/profile/model/profile_model.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetProfileProvider extends AsyncNotifier<ProfileData?> {
  Future<ProfileData?> getProfile() async {
    try {
      state = const AsyncLoading();
      final token = TokenStorage();
      final response =
          await ref.read(networkProvider).getRequest(path: '/auth/profile');
      final profile = ProfileModel.fromJson(response).data;

      token.saveUserId(profile!.id!);

      state = AsyncData(profile);

      return profile;
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
      return null;
    }
  }

  @override
  FutureOr<ProfileData?> build() {
    state = const AsyncLoading();
    return getProfile();
  }
}

final getProfileProvider =
    AsyncNotifierProvider<GetProfileProvider, ProfileData?>(
        GetProfileProvider.new);
