class Cache<T> {
  final Map<String, T> _cache = {};

  T? get(String key) {
    return _cache[key];
  }

  void set(String key, T value) {
    _cache[key] = value;
  }

  bool has(String key) {
    return _cache.containsKey(key);
  }

  void remove(String key) {
    _cache.remove(key);
  }

  void clear() {
    _cache.clear();
  }
}

void main() {
  var stringCache = Cache<String>();
  stringCache.set("greeting", "안녕하세요");
  print(stringCache.get("greeting"));

  var userCache = Cache<Map<String, dynamic>>();
  userCache.set("user1", {"name": "홍길동", "age": 30});
  var user = userCache.get("user1");
  print("사용자: ${user?["name"]}, 나이: ${user?["age"]}");
}
