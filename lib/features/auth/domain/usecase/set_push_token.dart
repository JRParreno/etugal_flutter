import 'package:fpdart/fpdart.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/auth/domain/repository/auth_repository.dart';

class SetPushToken implements UseCase<void, String> {
  final AuthRepository authRepository;

  const SetPushToken(this.authRepository);

  @override
  Future<Either<Failure, void>> call(String token) async {
    return await authRepository.setPushToken(token);
  }
}
