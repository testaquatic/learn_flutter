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

  void validatOrThrow() {
    if (!validate()) {
      throw ValidationException(getValidationErrors());
    }
  }
}

mixin Loggable {
  String get logTag {
    return runtimeType.toString();
  }

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
  String get formattedDate {
    return "$year-${month.toString().padLeft(2, "0")}-${day.toString().padLeft(2, "0")}";
  }

  bool isSameDay(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
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
      "created_at": createdAt.formattedDate,
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
    final erros = <String>[];

    if (id.isEmpty) {
      erros.add("ID는 비어 있을 수 없습니다.");
    }
    if (name.isEmpty) {
      erros.add("이름은 비어 있을 수 없습니다.");
    }
    if (!email.contains("@") || !email.contains(".")) {
      erros.add("유효한 이메일이 아닙니다.");
    }

    return erros;
  }
}

extension EmailValidation on String {
  bool get isValidEmail =>
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
    user1.validatOrThrow();
    user1.logInfo("사용자 유효성 검사 통과");
    print(user1.stringfy());

    final user2 = User(
      id: "user456",
      name: "",
      email: "invalid-email",
      createdAt: DateTime.now(),
    );
    user2.validatOrThrow();
  } catch (e) {
    print("오류 발생: $e");
  }

  final date = DateTime.now();
  print("오늘 날짜: ${date.formattedDate}");

  print("test@example.com은 유효한 이메일인가? ${"test@example.com".isValidEmail}");
  print("invalid-email은 유효한 이메일인가? ${"invalid-email".isValidEmail}");
}
