import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    loadTokensOnStartup(context);
  }

  Future<void> loadTokensOnStartup(BuildContext context) async {
    final tokenStorage = TokenStorage();
    final accessToken = await tokenStorage.getAccessToken();
    final refreshToken = await tokenStorage.getRefreshToken();

    if (context.mounted) {
      if (accessToken != null && refreshToken != null) {
        // Use the tokens to authenticate the user
        context.go(AppRoutes.onboarding);
      } else {
        // Redirect to login page
        context.go(AppRoutes.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
