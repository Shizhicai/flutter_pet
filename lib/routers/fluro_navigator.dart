import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'routers.dart';

class NavigatorUtils {
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    unfocus();
    Routes.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.cupertino ,
        routeSettings: RouteSettings(
          arguments: arguments,
        ));
  }

  static void pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearState = false, Object? arguments}) {
    unfocus();
    Routes.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearState,
            transition: TransitionType.cupertino ,
            routeSettings: RouteSettings(
              arguments: arguments,
            ))
        .then((Object? result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      print("$error");
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  /// 跳转WebView页
  static goWebViewPage(BuildContext context, String title, String url) {
    // fluro 不支持中文，需要转换
    push(context,
        '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

  /// 带参数范湖
  static void goBackWithParams(BuildContext context, Object request) {
    unfocus();
    Navigator.pop(context, request);
  }

  //点击空白节点关闭键盘
  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
