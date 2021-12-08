import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pet/page/home/home_page.dart';
import 'package:flutter_pet/page/login/login_router.dart';
import 'package:flutter_pet/page/not_found_page.dart';
import 'package:flutter_pet/page/other/webview_page.dart';
import 'package:flutter_pet/routers/i_router.dart';

class Routes {
  static String home = '/home';
  static String webViewPage = '/webView';

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      debugPrint("未找到页面");
      return const NotFoundPage();
    });

    // 首页
    router.define(home, handler: Handler(handlerFunc:
      (BuildContext? context, Map<String, List<String>> parameters)=> const HomePage()
    ));

    // WebView
    router.define(webViewPage, handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final String title = params['title']?.first ?? '';
      final String url = params['url']?.first ?? '';
      return WebViewPage(title: title, url: url);
    }));

    _listRouter.clear();

    /// TODO 各个路由模块统一添加初始化
    _listRouter.add(LoginRouter());
    void initRouter(IRouterProvider routerProvider) {
      routerProvider.initRouter(router);
    }

    _listRouter.forEach(initRouter);
  }
}
