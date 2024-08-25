import 'package:etugal_flutter/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessfulType, Params> {
  Future<Either<Failure, SuccessfulType>> call(Params params);
}

class NoParams {}

class SearchParams {
  final String keyword;
  final String? next;
  final String? previous;

  const SearchParams({
    required this.keyword,
    this.next,
    this.previous,
  });
}
