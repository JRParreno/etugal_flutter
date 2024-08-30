import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/config/shared_prefences_keys.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task/home_task_bloc.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task_category/home_task_category_bloc.dart';
import 'package:etugal_flutter/features/home/presentation/pages/body/index.dart';
import 'package:etugal_flutter/features/home/presentation/widgets/search_field.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchCtrl = TextEditingController();
  final taskCategoryScroll = ScrollController();
  final taskScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    handleGetInitialTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              SearchField(
                onChanged: () {
                  setState(() {});
                },
                onClearText: () {
                  searchCtrl.clear();
                  setState(() {});
                  handleOnSubmitSearch();
                },
                controller: searchCtrl,
                hintText: 'Search for a task',
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: ColorName.darkerGreyFont,
                ),
                onSubmit: () => handleOnSubmitSearch(searchCtrl.value.text),
              ),
              TaskCategoryList(searchCtrl: searchCtrl),
              TaskList(controller: taskScroll),
            ].withSpaceBetween(height: 15),
          ),
        ),
      ),
    );
  }

  void handleGetInitialTask() {
    context.read<HomeTaskCategoryBloc>().add(GetHomeTaskCategoryEvent());
  }

  void handleOnSubmitSearch([String keyword = '']) {
    Future.delayed(const Duration(milliseconds: 150), () {
      FocusScope.of(context).unfocus();
    });

    final taskCategoryState = context.read<HomeTaskCategoryBloc>().state;

    if (taskCategoryState is HomeTaskCategorySuccess) {
      context.read<HomeTaskBloc>().add(
            GetHomeTaskEvent(
              taskCategoryId:
                  taskCategoryState.data.results[taskCategoryState.selected].id,
              search: keyword,
            ),
          );
    }
  }

  void handleOnTapLogout() async {
    final result = await showOkCancelAlertDialog(
      context: context,
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
}
