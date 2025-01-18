import 'package:dollar_app/features/auth/view/verify_email_view.dart';
import 'package:dollar_app/features/main/admin/view/admin_view.dart';
import 'package:dollar_app/features/main/chat/view/chat_view.dart';
import 'package:dollar_app/features/main/feeds/view/feeds_details_view.dart';
import 'package:dollar_app/features/main/feeds/view/feeds_view.dart';
import 'package:dollar_app/features/main/feeds/view/new_feeds_view.dart';
import 'package:dollar_app/features/main/home/home_view.dart';
import 'package:dollar_app/features/main/polls/polls_view.dart';
import 'package:dollar_app/features/main/profile/model/profile_model.dart';
import 'package:dollar_app/features/main/profile/profile_view.dart';
import 'package:dollar_app/features/main/profile/views/edit_profile_view.dart';
import 'package:dollar_app/features/main/profile/views/stake_tickets.dart';
import 'package:dollar_app/features/main/profile/views/theme_view.dart';
import 'package:dollar_app/features/main/profile/views/ticket_details_view.dart';
import 'package:dollar_app/features/main/profile/views/view_profile.dart';
import 'package:dollar_app/features/main/videos/view/upload_video_view.dart';
import 'package:dollar_app/features/main/videos/view/videos_view.dart';
import 'package:dollar_app/features/set_up/view/set_up_succesful_page.dart';
import 'package:dollar_app/features/set_up/view/set_up_view.dart';
import 'package:dollar_app/features/startup/startup_view.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/view/forgot_password.dart';
import '../../features/auth/view/login_view.dart';
import '../../features/auth/view/otp_view.dart';
import '../../features/auth/view/register_view.dart';
import '../../features/main/bottom_nav_bar/bottom_navbar.dart';
import '../../features/onboarding/view/onboarding_view.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();
final _homeNavigationKey = GlobalKey<NavigatorState>();
final _poolsNavigationKey = GlobalKey<NavigatorState>();
final _feedsNavigationKey = GlobalKey<NavigatorState>();
final _chatNavigationKey = GlobalKey<NavigatorState>();

final router = Provider<GoRouter>((ref) {
  Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  return GoRouter(
      initialLocation: AppRoutes.startupView,
      navigatorKey: _rootNavigationKey,
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigationKey,
          path: AppRoutes.startupView,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: StartupView()),
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigationKey,
          path: AppRoutes.onboarding,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: OnboardingView()),
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigationKey,
          path: AppRoutes.login,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LoginView()),
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigationKey,
          path: AppRoutes.register,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: RegisterView()),
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigationKey,
          path: AppRoutes.otp,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: OTPView()),
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigationKey,
          path: AppRoutes.forgotPassword,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ChangePasswordPage()),
        ),
        GoRoute(
            parentNavigatorKey: _rootNavigationKey,
            path: "${AppRoutes.verifyEmail}/:email",
            pageBuilder: (context, state) {
              final email = state.pathParameters['email']!;
              return NoTransitionPage(
                child: VerifyEmailView(
                  email: email,
                ),
              );
            }),
        GoRoute(
            parentNavigatorKey: _rootNavigationKey,
            path: "${AppRoutes.setUp}/:email",
            pageBuilder: (context, state) {
              final email = state.pathParameters['email']!;

              return NoTransitionPage(
                child: SetUpView(
                  email: email,
                ),
              );
            }),
        GoRoute(
          parentNavigatorKey: _rootNavigationKey,
          path: AppRoutes.completeSetUp,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SetUPSuccessfulView()),
        ),
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: _rootNavigationKey,
          branches: [
            StatefulShellBranch(navigatorKey: _feedsNavigationKey, routes: [
              GoRoute(
                  path: AppRoutes.feeds,
                  pageBuilder: (context, state) {
                    return getPage(child: const FeedsView(), state: state);
                  },
                  routes: [
                    GoRoute(
                        parentNavigatorKey: _feedsNavigationKey,
                        path: 'new',
                        pageBuilder: (context, state) {
                          return CustomTransitionPage(
                              child: const NewFeedsView(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: const NewFeedsView(),
                                );
                              });
                        }),
                    GoRoute(
                        path: 'feedDetails/:postId',
                        builder: (BuildContext context, GoRouterState state) {
                          final postId = state.pathParameters['postId']!;
                          return FeedsDetailsView(postId: postId);
                        })
                  ])
            ]),

            StatefulShellBranch(navigatorKey: _poolsNavigationKey, routes: [
              GoRoute(
                  path: AppRoutes.polls,
                  pageBuilder: (context, state) {
                    return getPage(child: const PollsView(), state: state);
                  })
            ]),
            StatefulShellBranch(navigatorKey: _homeNavigationKey, routes: [
              GoRoute(
                  path: AppRoutes.home,
                  pageBuilder: (context, state) {
                    return getPage(child: const HomeView(), state: state);
                  }),
              GoRoute(
                  path: AppRoutes.profile,
                  pageBuilder: (context, state) {
                    return getPage(child: const ProfileView(), state: state);
                  },
                  routes: [
                    GoRoute(
                        path: 'viewProfile',
                        pageBuilder: (context, state) {
                          final userData = state.extra as ProfileData;
                          return getPage(
                              child: ViewProfile(
                                userData: userData,
                              ),
                              state: state);
                        }),
                    GoRoute(
                        path: 'editProfile',
                        pageBuilder: (context, state) {
                          final userData = state.extra as ProfileData;
                          return getPage(
                              child: EditProfileView(
                                userData: userData,
                              ),
                              state: state);
                        }),
                    GoRoute(
                        path: 'videos',
                        pageBuilder: (context, state) {
                          return getPage(
                              child: const VideosView(), state: state);
                        },
                        routes: [
                          GoRoute(
                              path: 'upload',
                              pageBuilder: (context, state) {
                                return getPage(
                                    child: const UploadVideoView(),
                                    state: state);
                              }),
                        ]),
                    GoRoute(
                        path: 'admin',
                        pageBuilder: (context, state) {
                          return getPage(
                              child: const AdminView(), state: state);
                        }),
                    GoRoute(
                        path: 'theme',
                        pageBuilder: (context, state) {
                          return getPage(
                              child: const ThemeView(), state: state);
                        }),
                    GoRoute(
                        path: 'tickets',
                        pageBuilder: (context, state) {
                          return getPage(
                              child: const StakeTicketsView(), state: state);
                        },
                        routes: [
                          GoRoute(
                              path: 'ticketDetails/:id',
                              pageBuilder: (context, state) {
                                final id = state.pathParameters['id']!;
                                return getPage(
                                    child: TicketDetailsView(id: id),
                                    state: state);
                              }),
                        ]),
                  ]),
            ]),
            StatefulShellBranch(navigatorKey: _chatNavigationKey, routes: [
              GoRoute(
                  path: AppRoutes.chat,
                  pageBuilder: (context, state) {
                    return getPage(child: const ChatView(), state: state);
                  })
            ])
          ],
          pageBuilder: (context, state, navigationShell) {
            return getPage(
                child: BottomNavbar(child: navigationShell), state: state);
          },
        )
      ]);
});
