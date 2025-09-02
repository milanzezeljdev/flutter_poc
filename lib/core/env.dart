import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_poc/core/error_handler.dart';

enum EnvKey {
  url("URL");

  final String _value;
  const EnvKey(this._value);
}

abstract class Env {
  static Future<void> load({required String fileName}) async {
    try {
      await dotenv.load(fileName: fileName);

      final variableKeys = EnvKey.values.map((e) => e._value);
      final variablesDefined = dotenv.isEveryDefined(variableKeys);

      if (!variablesDefined) {
        throw Exception("Environment variables are not defined");
      }

      for (final key in EnvKey.values) {
        get(key);
      }
    } catch (error, stackTrace) {
      throw ErrorHandler.handle(error, stackTrace);
    }
  }

  static String get(EnvKey key) => dotenv.get(key._value);
}
