import 'package:flutter_pet/base/mvps.dart';

abstract class FindPwdIMvpView implements IMvpView {
  void jumpSetPwdPage(String code, String phone);
}
