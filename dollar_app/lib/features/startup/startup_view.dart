
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

    // Get all required states
    final userOnboarded = await tokenStorage.getUserOnboarded();
    final userRegistered = await tokenStorage.getUserRegistered();
    final userEmail = await tokenStorage.getUserEmail();
    final userEmailVerified = await tokenStorage.getEmailVerified();
    final userProfileVerified = await tokenStorage.getUserProfileVerified();
    final isLoggedIn = await tokenStorage.userLoggedIN();
    if (context.mounted) {
      if (isLoggedIn == true) {
        context.go(AppRoutes.feeds);
      } else {
        if (userOnboarded == true) {
          if (userRegistered == true) {
            if (userEmail != null && userEmail.isNotEmpty) {
              if (userEmailVerified == true) {
                if (userProfileVerified == true) {
                  context.go(AppRoutes.feeds);
                } else {
                  context.go("${AppRoutes.setUp}/$userEmail");
                }
              } else {
                context.go("${AppRoutes.verifyEmail}/$userEmail");
              }
            } else {
              context.go(AppRoutes.register);
            }
          } else {
            context.go(AppRoutes.register);
          }
        } else {
          context.go(AppRoutes.onboarding);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
