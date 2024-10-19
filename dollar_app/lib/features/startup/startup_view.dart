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
    final isLoggedIn = await tokenStorage.getAccessToken() != null; // Add this line to check login state

    if (!context.mounted) return;

    // Decision tree for navigation
    if (!isLoggedIn) {
      // If user is not logged in, check onboarding and registration flow
      if (userOnboarded != true) {
        context.go(AppRoutes.onboarding);
        return;
      }

      if (userRegistered != true) {
        context.go(AppRoutes.register);
        return;
      }

      // If registered but not completed other steps
      if (userEmail?.isNotEmpty == true) {
        if (userEmailVerified != true) {
          context.go("${AppRoutes.verifyEmail}/$userEmail");
          return;
        }

        if (userProfileVerified != true) {
          context.go("${AppRoutes.setUp}/$userEmail");
          return;
        }
      } else {
        context.go(AppRoutes.register);
        return;
      }
    } else {
      // User is logged in
      if (userProfileVerified == true) {
        // If logged in and profile is verified, go straight to home
        context.go(AppRoutes.home);
      } else if (userEmail?.isNotEmpty == true) {
        // If logged in but profile not verified, complete setup
        context.go("${AppRoutes.setUp}/$userEmail");
      } else {
        // Fallback - something's wrong with the state, logout and restart flow
        await tokenStorage.clearTokens();
        context.go(AppRoutes.register);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
