import 'dart:async';

void main(List<String> arguments) {
  runZonedGuarded(
    () {
      print("Zone 내에서 코드 실행 시작");

      Future.delayed(Duration(seconds: 1), () {
        throw Exception("비동기 오류");
      });

      Timer(Duration(seconds: 2), () {
        throw Exception("타이머 내 오류");
      });
    },
    ((error, stack) {
      print("Zone에서 오류 캐치: $error");
      print("스택 트레이스: $stack");
    }),
  );

  print("main 함수의 끝 (Zone은 계속 실행됨)");
}
