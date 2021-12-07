import 'package:flutter/foundation.dart';

class Constant {
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = "data";
  static const String message = "message";
  static const String code = "code";

  static const String spToken = "token";
  static const String spShowGuide = "showGuide";
  static const String spPhone = "phone";
  static const String spLoginEntity = 'loginEntity';

  static const String baseUrl = "http://kza666.com/gateway/";

  static const String htmlUserProtocol =
      "http://kza666.com/protocol/privacy.html"; // 用户协议
  static const String htmlPrivacyProtocol =
      "http://kza666.com/protocol/userAgreement.html"; // 隐私协议
}
