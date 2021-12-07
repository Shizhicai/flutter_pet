/// String 空安全处理
extension StringExtension on String? {
  String get nullSafe => this ?? '';
}

extension StringCheckPhoneExtension on String {
  bool checkPhone() => RegExp(
          '^((13[0-9])|(14[0-9])|(15[^4,\\D])|(18[0-9])|(17[0-9])|(16[0-9])|(19[0-9]))\\d{8}\$')
      .hasMatch(this);
}
