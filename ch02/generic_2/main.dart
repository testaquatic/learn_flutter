abstract class Result<S, E> {
  Result();

  factory Result.success(S value) = Success<S, E>;
  factory Result.failure(E error) = Failure<S, E>;

  bool get isSuccess;
  bool get isFailure;

  S? get value;
  E? get error;

  void when({
    required void Function(S value) success,
    required void Function(E error) failure,
  });
}

class Success<S, E> extends Result<S, E> {
  final S _value;

  Success(this._value);

  @override
  bool get isSuccess => true;

  @override
  bool get isFailure => false;

  @override
  S? get value => _value;

  @override
  E? get error => null;

  @override
  void when({
    required void Function(S value) success,
    required void Function(E error) failure,
  }) {
    success(_value);
  }
}

class Failure<S, E> extends Result<S, E> {
  final E _error;

  Failure(this._error);

  @override
  bool get isSuccess => false;

  @override
  bool get isFailure => true;

  @override
  S? get value => null;

  @override
  E? get error => _error;

  @override
  void when({
    required void Function(S value) success,
    required void Function(E error) failure,
  }) {
    failure(_error);
  }
}

Result<String, Exception> fetchData() {
  try {
    return Result.success("데이터");
  } catch (e) {
    return Result.failure(Exception("데이터를 가져오는 중 오류 발생: $e"));
  }
}

void main() {
  final result = fetchData();

  result.when(
    success: (data) {
      print("성공: $data");
    },
    failure: (error) {
      print("싱패: $error");
    },
  );
}
