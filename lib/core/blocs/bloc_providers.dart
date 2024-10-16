import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etugal_flutter/features/change_password/data/blocs/bloc/change_password_bloc.dart';
import 'package:etugal_flutter/features/change_password/data/repository/change_password_repository_impl.dart';
import 'package:etugal_flutter/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:etugal_flutter/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:etugal_flutter/features/forgot_password/data/blocs/bloc/forgot_password_bloc.dart';
import 'package:etugal_flutter/features/forgot_password/data/repository/forgot_password_repository_impl.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task/home_task_bloc.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task_category/home_task_category_bloc.dart';
import 'package:etugal_flutter/features/profile/presentation/blocs/update_profile/update_profile_bloc.dart';
import 'package:etugal_flutter/features/profile/presentation/blocs/verification_image_upload/verification_image_upload_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task/add_task_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task_category/add_task_category_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/cubit/review_star_cubit.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/edit_task/edit_task_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/my_task_detail/my_task_detail_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/performer_task_list/performer_task_list_bloc.dart';
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
      BlocProvider(
        create: (context) => serviceLocator<PerformerTaskListBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<ReviewStarCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<EditTaskBloc>(),
      ),
      BlocProvider(
        create: (context) => ChangePasswordBloc(
          changePasswordRepository: ChangePasswordRepositoryImpl(),
        ),
      ),
      BlocProvider(
        create: (context) => ForgotPasswordBloc(
          forgotPasswordRepository: ForgotPasswordRepositoryImpl(),
        ),
      ),
      BlocProvider(
        create: (context) => serviceLocator<ChatBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<ChatListBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<UpdateProfileBloc>(),
      ),
    ];
  }
}
