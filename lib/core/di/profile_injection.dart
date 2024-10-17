import 'package:etugal_flutter/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:etugal_flutter/features/profile/data/repository/profile_repository_impl.dart';
import 'package:etugal_flutter/features/profile/domain/repository/profile_repository.dart';
import 'package:etugal_flutter/features/profile/domain/usecase/index.dart';
import 'package:etugal_flutter/features/profile/presentation/blocs/update_profile/update_profile_bloc.dart';
import 'package:etugal_flutter/features/profile/presentation/blocs/verification_image_upload/verification_image_upload_bloc.dart';
import 'package:get_it/get_it.dart';

void initProfile(GetIt serviceLocator) {
  serviceLocator
    // Datasource
    ..registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => UploadGovernmentId(serviceLocator()),
    )
    ..registerFactory(
      () => UploadSelfie(serviceLocator()),
    )
    ..registerFactory(
      () => UpdateProfile(serviceLocator()),
    )
    ..registerFactory(
      () => UploadProfilePhoto(serviceLocator()),
    )
    // Bloc
    ..registerFactory(
      () => VerificationImageUploadBloc(
        uploadGovernmentId: serviceLocator(),
        uploadSelfie: serviceLocator(),
      ),
    )
    ..registerFactory(() => UpdateProfileBloc(
        updateProfile: serviceLocator(),
        updatePhoto: serviceLocator(),
        appUserCubit: serviceLocator()));
}
