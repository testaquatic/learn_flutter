import 'dart:convert';

mixin JsonSerializable {
  Map<String, dynamic> toJson();

  String stringfy() {
    return jsonEncode(toJson());
  }
}

mixin Validatable {
  bool validate();

  List<String> getValidationErrors();

  void validateOrThrow() {
    if (!validate()) {
      throw ValidationException(getValidationErrors());
    }
  }
}

mixin Loggable {
  String get logTag => runtimeType.toString();

  void log(String message) {
    print("[$logTag] $message");
  }

  void logInfo(String message) {
    log("INFO: $message");
  }

  void logError(String message) {
    log("ERROR: $message");
  }
}

class ValidationException implements Exception {
  final List<String> errors;

  ValidationException(this.errors);

  @override
  String toString() {
    return "ValidationException: ${errors.join(", ")}";
  }
}

extension DateTimeExtension on DateTime {
  String get formattedDate =>
      "$year-${month.toString().padLeft(2, "0")}-${day.toString().padLeft(2, "0")}";

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class User with JsonSerializable, Validatable, Loggable {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  }) {
    logInfo("새 사용자 생성: $name");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "createdAt": createdAt.formattedDate,
    };
  }

  @override
  bool validate() {
    return id.isNotEmpty &&
        name.isNotEmpty &&
        email.contains("@") &&
        email.contains(".");
  }

  @override
  List<String> getValidationErrors() {
    final errors = <String>[];

    if (id.isEmpty) {
      errors.add("ID는 비어있을 수 없습니다.");
    }

    if (name.isEmpty) {
      errors.add("이름은 비어있을 수 없습니다.");
    }

    if (!email.contains("@") || !email.contains(".")) {
      errors.add("유요한 이메일이 아닙니다.");
    }

    return errors;
  }
}

extension EmailValidation on String {
  bool get inValidEmail =>
      RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(this);
}

void main() {
  try {
    final user1 = User(
      id: "user123",
      name: "홍길동",
      email: "hong@example.com",
      createdAt: DateTime.now(),
    );

    user1.validateOrThrow();
    user1.logInfo("사용자 유효성 검사 통과");
    print(user1.stringfy());

    final user2 = User(
      id: "user456",
      name: "",
      email: "invalid-email",
      createdAt: DateTime.now(),
    );

    user2.validateOrThrow();
  } catch (e) {
    print("오류 발생: $e");
  }

  final date = DateTime.now();
  print("오늘 날짜: ${date.formattedDate}");

  print("test@example.com은 유효한 이메일인가? ${"test@example.com".inValidEmail}}");
  print("invalid-email은 유효한 이메일인가? ${"invalid-email".inValidEmail}}");
}
