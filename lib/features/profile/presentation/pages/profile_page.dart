import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/config/shared_prefences_keys.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:etugal_flutter/features/profile/presentation/widgets/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_provider_review/task_provider_review_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/task_detail/index.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/task_provider/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TaskUserProfileEntity userProfile;
  late final TabController _mainTabCtrl;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final userCubitState = context.read<AppUserCubit>().state;
    if (userCubitState is AppUserLoggedIn) {
      userProfile = TaskUserProfileEntity(
        id: int.parse(userCubitState.user.profilePk),
        user: TaskUserEntity(
            pk: int.parse(userCubitState.user.pk),
            email: userCubitState.user.email,
            firstName: userCubitState.user.firstName,
            lastName: userCubitState.user.lastName,
            username: userCubitState.user.username,
            getFullName:
                '${userCubitState.user.firstName} ${userCubitState.user.lastName}'),
        birthdate: userCubitState.user.birthdate,
        address: userCubitState.user.address,
        contactNumber: userCubitState.user.contactNumber,
        gender: userCubitState.user.gender,
        verificationStatus: userCubitState.user.verificationStatus,
        profilePhoto: userCubitState.user.profilePhoto,
        verificationRemarks: userCubitState.user.verificationRemarks,
        suspensionReason: userCubitState.user.suspensionReason,
        terminationReason: userCubitState.user.terminationReason,
        idPhoto: userCubitState.user.idPhoto,
        isSuspeneded: userCubitState.user.isSuspeneded,
        isTerminated: userCubitState.user.isTerminated,
        suspendedUntil: userCubitState.user.suspendedUntil,
      );

      context.read<TaskProviderReviewBloc>().add(
            GetTaskProviderReviewEvent(
                int.parse(userCubitState.user.profilePk)),
          );
    }

    _mainTabCtrl = TabController(length: 2, vsync: this);

    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AppUserCubit, AppUserState>(
          builder: (context, state) {
            if (state is AppUserLoggedIn) {
              return Stack(
                children: [
                  Container(
                    height: mediaQuery.size.height,
                    width: mediaQuery.size.width,
                    margin: EdgeInsets.only(
                      top: mediaQuery.size.height * 0.18,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorName.containerStroke,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Container(
                      margin:
                          EdgeInsets.only(top: mediaQuery.size.height * 0.14),
                      child: Column(
                        children: [
                          TabBar(
                            controller: _mainTabCtrl,
                            labelStyle: textTheme.bodyMedium
                                ?.copyWith(color: ColorName.primary),
                            indicatorColor: ColorName.primary,
                            dividerHeight: 0,
                            tabs: const [
                              Tab(
                                child: Text(
                                  'Reviews',
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'About',
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _mainTabCtrl,
                              children: <Widget>[
                                ProviderReviewList(
                                  controller: scrollController,
                                  userId: userProfile.id,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        color: ColorName.borderColor),
                                  ),
                                  child: PerformerInfo(
                                    taskUserProfile: userProfile,
                                    isHideHeader: true,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: mediaQuery.size.height * 0.19,
                    right: 10,
                    child: IconButton(
                      onPressed: handleOnTapProfileSettings,
                      icon: const Icon(
                        Icons.settings_outlined,
                        size: 32,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin:
                          EdgeInsets.only(top: mediaQuery.size.height * 0.08),
                      child: ProfileAvatarDetail(
                        user: state.user,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Center(
              child:
                  CustomElevatedBtn(onTap: handleOnTapLogout, title: 'Logout'),
            );
          },
        ),
      ),
    );
  }

  void handleOnTapProfileSettings() {
    GoRouter.of(context).pushNamed(AppRoutes.profileSettings.name);
  }

  void handleOnTapLogout() async {
    final result = await showOkCancelAlertDialog(
      context: context,
      style: AdaptiveStyle.iOS,
      title: 'Logout',
      message: 'Do you want to logout',
      canPop: true,
      okLabel: 'Ok',
      cancelLabel: 'Cancel',
    );

    if (result.name != OkCancelResult.cancel.name) {
      final sharedPreferencesNotifier =
          GetIt.instance<SharedPreferencesNotifier>();

      sharedPreferencesNotifier.setValue(
          SharedPreferencesKeys.isLoggedIn, false);
      if (mounted) {
        context.read<AppUserCubit>().logout();

        context.go(AppRoutes.onBoarding.path);
      }
    }
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        context.read<TaskProviderReviewBloc>().add(
              PaginateTaskProviderReviewEvent(userProfile.id),
            );
      }
    });
  }
}
