import 'package:etugal_flutter/core/common/entities/result.dart';

Future<Result<T>> safeFuture<T>(Future<T> future) async {
  try {
    final data = await future;
    return Result(data: data);
  } catch (error) {
    return Result(error: error);
  }
}
