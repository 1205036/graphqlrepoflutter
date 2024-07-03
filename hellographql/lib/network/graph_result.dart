class GraphqlResult<T> {
  final T? data;
  final int? code;
  final String? error;

  GraphqlResult({
    this.data,
    this.code,
    this.error,
  });
}

class GraphqlResultSuccess<T> extends GraphqlResult<T> {
  GraphqlResultSuccess({
    required super.data,
    super.code = 1,
  });
}

class GraphqlResultFailure<T> extends GraphqlResult<T> {
  GraphqlResultFailure({
    required super.error,
    super.code = 0,
  });
}