import 'dart:async';

import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends AsyncNotifier<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String firstName = '';
  String lastName = '';

  Future<void> signInWithGoogle(context) async {
    try {
      state = const AsyncLoading();
      final token = TokenStorage();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      String displayName = userCredential.user?.displayName ?? "";

      List<String> words = displayName.split(' ');

      if (words.length > 1) {
        firstName = words[0];

        lastName = words.sublist(1).join(" ");
      } else {
        firstName = words[0];
        lastName = "";
      }

      final body = {
        "googleId": userCredential.user?.uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': userCredential.user?.email,
        'photoUrl': userCredential.user?.photoURL
      };

      final res = await ref
          .read(networkProvider)
          .postRequest(path: '/auth/google', body: body);
      if (res['status'] == true) {
        token.saveTokens(
            res['data']['accessToken'], res['data']['refreshToken']);
        ref.read(router).go(AppRoutes.home);
      }
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  @override
  FutureOr<User?> build() {
    return null;
  }
}

final googleSinginProvider = AsyncNotifierProvider<GoogleSignInProvider, User?>(
    GoogleSignInProvider.new);
