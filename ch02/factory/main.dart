class Logger {
  final String name;
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  Logger._internal(this.name);

  void log(String msg) {
    print('[$name] $msg');
  }
}

void main() {
  final logger1 = Logger("UI");
  final logger2 = Logger("API");
  final logger3 = Logger("UI");

  print(identical(logger1, logger2));
  print(identical(logger1, logger3));

  logger1.log("Button clicked");
  logger2.log("Something went wrong");
}
