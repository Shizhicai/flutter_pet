import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet/base/base_presenter.dart';
import 'package:flutter_pet/base/mvps.dart';
import 'package:flutter_pet/routers/fluro_navigator.dart';
import 'package:flutter_pet/utils/log_utils.dart';
import 'package:flutter_pet/utils/toast_utils.dart';
import 'package:flutter_pet/widget/progress_dialog.dart';

mixin BasePageMixin<T extends StatefulWidget, P extends BasePresenter>
    on State<T> implements IMvpView {
  P? presenter;
  bool _isShowDialog = false;

  P createPresenter();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void initState() {
    Log.d('$T ==> initState');
    presenter = createPresenter();
    presenter?.view = this;
    presenter?.initState();
    super.initState();
  }

  @override
  void closeProgress() {
    // mounted 是 bool 类型，表示当前 State 是否加载到树⾥。
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
    }
  }

  @override
  void showProgress({String hint = "请稍等..."}) {
    /// 避免重复弹出
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            barrierColor: const Color(0x00FFFFFF),
            builder: (_) {
              return WillPopScope(
                  child: buildProgress(hint),
                  onWillPop: () async {
                    // 拦截到返回键，证明dialog被手动关闭
                    _isShowDialog = false;
                    return Future.value(true);
                  });
            });
      } catch (e) {
        print(e);
      }
    }
  }

  Widget buildProgress(String hint) => ProgressDialog(hintText: hint);

  @override
  void showToast(String str) {
    Toast.show(str);
  }

  @override
  void didChangeDependencies() {
    presenter?.didChangeDependencies();
    Log.d('$T ==> didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    presenter?.dispose();
    Log.d('$T ==> dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    presenter?.deactivate();
    Log.d('$T ==> deactivate');
    super.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    presenter?.didUpdateWidgets<T>(oldWidget);
    Log.d('$T ==> didUpdateWidgets');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void jumpPage(String path,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    NavigatorUtils.push(context, path,
        replace: replace, clearStack: clearStack, arguments: arguments);
  }
}
