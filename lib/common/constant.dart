import 'package:flutter/foundation.dart';

class Constant {
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = "data";
  static const String message = "message";
  static const String code = "code";

  static const String spToken = "token";

  static const String baseUrl = "http://kza666.com/gateway/";
}
