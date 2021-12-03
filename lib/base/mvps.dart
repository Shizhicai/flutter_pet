import 'package:flutter/cupertino.dart';
import 'package:flutter_pet/base/i_lifecycle.dart';

abstract class IMvpView {
  BuildContext getContext();

  void showProgress({String hint = "请稍等..."});

  void closeProgress();

  void showToast(String str);
}

abstract class IPresenter extends ILifecycle {}
