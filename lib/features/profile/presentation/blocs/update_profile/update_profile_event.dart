part of 'update_profile_bloc.dart';

sealed class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

final class UpdateProfileTrigger extends UpdateProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String birthdate;
  final String contactNumber;
  final String gender;

  const UpdateProfileTrigger({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.birthdate,
    required this.contactNumber,
    required this.gender,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        email,
        gender,
        address,
        contactNumber,
        birthdate,
      ];
}

final class UpdatePhotoTrigger extends UpdateProfileEvent {
  final String path;

  const UpdatePhotoTrigger(this.path);

  @override
  List<Object> get props => [path];
}
