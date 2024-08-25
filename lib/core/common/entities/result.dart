class Result<T> {
  final T? data;
  final Object? error;

  Result({this.data, this.error});

  bool get isSuccess => error == null;
}
