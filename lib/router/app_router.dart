import 'dart:async';

import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/config/shared_prefences_keys.dart';
import 'package:etugal_flutter/core/error/error_page.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:etugal_flutter/features/auth/presentation/pages/index.dart';
import 'package:etugal_flutter/features/change_password/presentation/pages/change_password_screen.dart';
import 'package:etugal_flutter/features/chat/presentation/pages/chat_list_page.dart';
import 'package:etugal_flutter/features/chat/presentation/pages/chat_page.dart';
import 'package:etugal_flutter/features/home/presentation/pages/home_page.dart';
import 'package:etugal_flutter/features/navigation/presentation/scaffold_with_bottom_nav.dart';
import 'package:etugal_flutter/features/on_boarding/on_boarding.dart';
import 'package:etugal_flutter/features/profile/presentation/pages/process_verification_page.dart';
import 'package:etugal_flutter/features/profile/presentation/pages/profile_page.dart';
import 'package:etugal_flutter/features/profile/presentation/pages/profile_settings_page.dart';
import 'package:etugal_flutter/features/profile/presentation/pages/reject_verification_page.dart';
import 'package:etugal_flutter/features/profile/presentation/pages/upload_government_id_page.dart';
import 'package:etugal_flutter/features/profile/presentation/pages/upload_selfie_page.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/presentation/pages/add_post_task_page.dart';
import 'package:etugal_flutter/features/task/presentation/pages/edit_post_task_page.dart';
import 'package:etugal_flutter/features/task/presentation/pages/my_performer_task_detail_page.dart';
import 'package:etugal_flutter/features/task/presentation/pages/my_task_detail_page.dart';
import 'package:etugal_flutter/features/task/presentation/pages/my_task_list_page.dart';
import 'package:etugal_flutter/features/task/presentation/pages/task_applicant_detail_page.dart';
import 'package:etugal_flutter/features/task/presentation/pages/task_detail_page.dart';
import 'package:etugal_flutter/features/task/presentation/pages/task_provider_detail_page.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// Contains all of the app routes configurations
GoRouter routerConfig() {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'mainNavigator');
  final shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorHomeKey');
  final shellNavigatorTaskKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorTaskKey');
  final shellNavigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorProfileKey');
  final shellNavigatorChatKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorChatKey');

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.onBoarding.path,
    errorPageBuilder: (context, state) {
      return buildTransitionPage(
        localKey: state.pageKey,
        child: const ErrorPage(),
      );
    },
    refreshListenable:
        GoRouterRefreshStream(GetIt.instance<AppUserCubit>().stream),
    redirect: (context, state) {
      final sharedPreferencesNotifier =
          GetIt.instance<SharedPreferencesNotifier>();
      final bool isLoggedIn = sharedPreferencesNotifier.getValue(
          SharedPreferencesKeys.isLoggedIn, false);

      final onBoardingPath = state.matchedLocation == AppRoutes.onBoarding.path;
      final profilePath = state.matchedLocation == AppRoutes.profile.path;

      if (isLoggedIn && onBoardingPath) {
        return AppRoutes.home.path;
      }

      if (!isLoggedIn && (onBoardingPath || profilePath)) {
        return AppRoutes.onBoarding.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onBoarding.path,
        name: AppRoutes.onBoarding.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const OnBoardingPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.signup.path,
        name: AppRoutes.signup.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const SingupPage(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) => ScaffoldWithBottomNav(child: child),
        branches: [
          StatefulShellBranch(
            navigatorKey: shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: AppRoutes.home.path,
                name: AppRoutes.home.name,
                pageBuilder: (context, state) {
                  return buildTransitionPage(
                    localKey: state.pageKey,
                    child: const HomePage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorTaskKey,
            routes: [
              GoRoute(
                path: AppRoutes.myTaskList.path,
                name: AppRoutes.myTaskList.name,
                pageBuilder: (context, state) {
                  MyTaskListParams params = const MyTaskListParams(0);
                  if (state.extra != null) {
                    params = state.extra! as MyTaskListParams;
                  }
                  return buildTransitionPage(
                    localKey: state.pageKey,
                    child: MyTaskListPage(
                      params: params,
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorProfileKey,
            routes: [
              GoRoute(
                  path: AppRoutes.profile.path,
                  name: AppRoutes.profile.name,
                  pageBuilder: (context, state) {
                    return buildTransitionPage(
                      localKey: state.pageKey,
                      child: const ProfilePage(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: AppRoutes.updateProfile.path,
                      name: AppRoutes.updateProfile.name,
                      pageBuilder: (context, state) {
                        return buildTransitionPage(
                          localKey: state.pageKey,
                          child: const Placeholder(),
                        );
                      },
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorChatKey,
            routes: [
              GoRoute(
                path: AppRoutes.chatList.path,
                name: AppRoutes.chatList.name,
                pageBuilder: (context, state) {
                  return buildTransitionPage(
                    localKey: state.pageKey,
                    child: const ChatListPage(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.uploadGovernmentId.path,
        name: AppRoutes.uploadGovernmentId.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const UploadGovernmentIdPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.uploadSelfie.path,
        name: AppRoutes.uploadSelfie.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const UploadSelfiePage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.processVerification.path,
        name: AppRoutes.processVerification.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const ProcessVerificationPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.rejectVerification.path,
        name: AppRoutes.rejectVerification.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const RejectVerificationPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.addPostTask.path,
        name: AppRoutes.addPostTask.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const AddPostTaskPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.taskDetail.path,
        name: AppRoutes.taskDetail.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: TaskDetailPage(
              task: state.extra! as TaskEntity,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.myTaskDetail.path,
        name: AppRoutes.myTaskDetail.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: MyTaskDetailPage(
              task: state.extra! as TaskEntity,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.performerTaskDetail.path,
        name: AppRoutes.performerTaskDetail.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: MyPerformerTaskDetailPage(
              task: state.extra! as TaskEntity,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.taskApplicantDetail.path,
        name: AppRoutes.taskApplicantDetail.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: TaskApplicantDetailPage(
              userProfile: state.extra! as TaskUserProfileEntity,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.taskProviderDetail.path,
        name: AppRoutes.taskProviderDetail.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: TaskProviderDetailPage(
              userProfile: state.extra! as TaskUserProfileEntity,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.profileSettings.path,
        name: AppRoutes.profileSettings.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const ProfileSettingsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.changePassword.path,
        name: AppRoutes.changePassword.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const ChangePasswordScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.myEditTaskDetail.path,
        name: AppRoutes.myEditTaskDetail.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: EditPostTaskPage(
              task: state.extra as TaskEntity,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.chat.path,
        name: AppRoutes.chat.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: ChatPage(
              args: state.extra as ChatArgs,
            ),
          );
        },
      ),
    ],
  );
}

CustomTransitionPage buildTransitionPage({
  required LocalKey localKey,
  required Widget child,
}) {
  return CustomTransitionPage(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.linearToEaseOut).animate(animation),
        child: child,
      );
    },
    key: localKey,
    child: child,
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
