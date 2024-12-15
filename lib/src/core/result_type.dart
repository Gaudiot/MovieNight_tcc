class Result<T, E> {
  final T? data;
  final E? error;

  Result.ok({this.data}) : error = null;
  Result.error({this.error}) : data = null;

  bool get isOk => error == null;
  bool get hasError => error != null;

  bool get hasData => data != null;

  void when({
    Function(T? data)? onOk,
    Function(E error)? onError,
  }) {
    if (isOk) onOk?.call(data as T);
    if (hasError) onError?.call(error as E);
  }
}
