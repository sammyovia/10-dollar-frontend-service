import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dollar_app/features/main/profile/providers/get_profile_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';

import '../../main/admin/videos/provider/video_provider.dart';
import '../../main/profile/providers/ticket_provider.dart';

class SetUpProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> setup(
    context, {
    required String firstName,
    required String lastName,
    required File? attachment,
    required String email,
    required String gender,
    required String phoneNumber,
    bool fromProfile = false,
  }) async {
    final token = TokenStorage();
    try {
      state = const AsyncLoading();

      FormData formData = FormData.fromMap({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "gender": gender,
        "phoneNumber": phoneNumber
      });

      if (attachment != null) {
        String fileName = attachment.path.split('/').last;
        String? mimeType = lookupMimeType(attachment.path);

        formData.files.add(
          MapEntry(
            'attachment',
            await MultipartFile.fromFile(
              attachment.path,
              filename: fileName,
              contentType:
                  DioMediaType.parse(mimeType ?? 'application/octect-stream'),
            ),
          ),
        );
      }

      final response = await ref
          .read(networkProvider)
          .putRequest(path: '/auth/profile/setup', body: formData);
      log(response.toString());
      if (response['status'] == true) {
        ref.read(getProfileProvider.notifier).getProfile();
        ref.read(ticketProvider.notifier).getTickets();
        ref.read(videoProvider.notifier).getVideos();

        token.userProfileVerified(true);

        if (fromProfile) {
          Toast.showErrorToast(context, "profile edited successfully");
        } else {
          ref.read(router).go(AppRoutes.completeSetUp);
        }
      }
      state = AsyncData(response);
      await future;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
      log(e.toString());
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    return {};
  }
}

final setUpProvider =
    AsyncNotifierProvider<SetUpProvider, Map<String, dynamic>>(
        SetUpProvider.new);
