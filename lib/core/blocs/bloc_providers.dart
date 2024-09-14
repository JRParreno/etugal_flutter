import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task/home_task_bloc.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task_category/home_task_category_bloc.dart';
import 'package:etugal_flutter/features/profile/presentation/blocs/verification_image_upload/verification_image_upload_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task/add_task_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task_category/add_task_category_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/my_task_detail/my_task_detail_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/provider_task_list/provider_task_list_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_applicant_review/task_applicant_review_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_detail/task_detail_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_provider_review/task_provider_review_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BlocProviders {
  static blocs(GetIt serviceLocator) {
    return [
      BlocProvider(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<HomeTaskCategoryBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<HomeTaskBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<VerificationImageUploadBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AddTaskCategoryBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AddTaskBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<ProviderTaskListBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<MyTaskDetailBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<TaskApplicantReviewBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<TaskProviderReviewBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<TaskDetailBloc>(),
      ),
    ];
  }
}
