import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/profile/domain/repository/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateProfile implements UseCase<User, UpdateProfileParams> {
  final ProfileRepository profileRepository;

  const UpdateProfile(this.profileRepository);

  @override
  Future<Either<Failure, User>> call(UpdateProfileParams params) async {
    return await profileRepository.updateProfile(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      address: params.address,
      birthdate: params.birthdate,
      contactNumber: params.contactNumber,
      gender: params.gender,
    );
  }
}

class UpdateProfileParams {
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String birthdate;
  final String contactNumber;
  final String gender;

  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.birthdate,
    required this.contactNumber,
    required this.gender,
  });
}
