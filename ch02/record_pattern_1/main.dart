Map<String, dynamic> fetchUserResponse() {
  return {
    "status": "success",
    "data": {
      "user": {
        "id": 123,
        "name": "홍길동",
        "email": "hong@example.com",
        "addresses": [
          {"type": "home", "city": "서울", "zipcode": "12345"},
          {"type": "work", "city": "부산", "zipcode": "67890"},
        ],
      },
    },
  };
}

void main() {
  var response = fetchUserResponse();

  switch (response) {
    case {"status": "success", "data": {"user": final user}}:
      if (user case {
        "name": final String name,
        "email": final String email,
        "addresses": final addresses,
      }) {
        print("사용자 이름: $name, 이메일: $email");

        if (addresses case List<Map<String, dynamic>> addressList) {
          for (final address in addressList) {
            if (address case {"type": "home", "city": final String city}) {
              print("집 주소: $city");
            }
          }
        }
      }
    case {"status": "error", "message": final String message}:
      print("에러 메시지: $message");
    default:
      print("알 수 없는 응답");
  }
}
