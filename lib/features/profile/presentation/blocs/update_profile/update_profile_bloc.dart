import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/profile/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfile _updateProfile;
  final UploadProfilePhoto _updatePhoto;
  final AppUserCubit _appUserCubit;

  UpdateProfileBloc({
    required UpdateProfile updateProfile,
    required UploadProfilePhoto updatePhoto,
    required AppUserCubit appUserCubit,
  })  : _updateProfile = updateProfile,
        _updatePhoto = updatePhoto,
        _appUserCubit = appUserCubit,
        super(UpdateProfileInitial()) {
    on<UpdateProfileTrigger>(onUpdateProfileTrigger);
    on<UpdatePhotoTrigger>(onUpdatePhotoTrigger);
  }

  Future<void> onUpdateProfileTrigger(
      UpdateProfileTrigger event, Emitter<UpdateProfileState> emit) async {
    emit(UpdateProfileLoading());

    final response = await _updateProfile.call(
      UpdateProfileParams(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        address: event.address,
        birthdate: event.birthdate,
        contactNumber: event.contactNumber,
        gender: event.gender,
      ),
    );

    response.fold(
      (l) => emit(UpdateProfileFailure(l.message)),
      (r) {
        emit(UpdateProfileSuccess(r));
        _appUserCubit.updateUser(r);
      },
    );
  }

  Future<void> onUpdatePhotoTrigger(
      UpdatePhotoTrigger event, Emitter<UpdateProfileState> emit) async {
    final appUserState = _appUserCubit.state;

    if (appUserState is AppUserLoggedIn) {
      emit(UpdateProfileLoading());

      final response = await _updatePhoto.call(
        UploadImageParams(
          imagePath: event.path,
          userId: appUserState.user.profilePk,
        ),
      );

      response.fold(
        (l) {
          return emit(UpdateProfileFailure(l.message));
        },
        (r) {},
      );

      final userResponse = await _updateProfile.call(
        UpdateProfileParams(
          firstName: appUserState.user.firstName,
          lastName: appUserState.user.lastName,
          email: appUserState.user.email,
          address: appUserState.user.address,
          birthdate: DateFormat.yMd().format(appUserState.user.birthdate),
          contactNumber: appUserState.user.contactNumber,
          gender: appUserState.user.gender,
        ),
      );

      userResponse.fold(
        (l) => emit(UpdateProfileFailure(l.message)),
        (r) {
          emit(UpdateProfileSuccess(r));
          _appUserCubit.updateUser(r);
        },
      );
    }
  }
}
