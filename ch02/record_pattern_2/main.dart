(bool isValid, {String? data, String? error}) validateUserData(Object input) {
  return switch (input) {
    Map<String, dynamic> map
        when map.containsKey("name") && map.containsKey("age") =>
      map["age"] is int && map["age"] > 0
          ? (true, data: "유효한 사용자 데이터", error: null)
          : (false, data: null, error: "나이는 양의 정수여야 합니다."),
    (String _, final age) when age is int && age > 0 => (
      true,
      data: "유효한 사용자 레코드",
      error: null,
    ),
    String s when RegExp(r"^[a-zA-Z0-9]+,\s*\d+").hasMatch(s) => (
      true,
      data: "유효한 사용자 문자열",
      error: null,
    ),
    _ => (false, data: null, error: "지원하지 않는 형식"),
  };
}

void main() {
  final result1 = validateUserData({"name": "홍길동", "age": 30});
  final result2 = validateUserData(("김철수", 25));
  final result3 = validateUserData("이영희, 20");
  final result4 = validateUserData({"name": "박지성", "age": -5});
  final result5 = validateUserData(42);

  for (final result in [result1, result2, result3, result4, result5]) {
    if (result.$1) {
      print("검증 성공: ${result.data}");
    } else {
      print("검증 실패: ${result.error}");
    }
  }
}
