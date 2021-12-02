import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pet/page/not_found_page.dart';
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
    // router.define(home, handler: Handler(handlerFunc:
    //   (BuildContext? context, Map<String, List<String>> parameters)=> Home()
    // ));

    // WebView
    // router.define(webViewPage, handler: Handler(handlerFunc: handlerFunc))

    _listRouter.clear();

    /// 各个路由模块统一添加初始化
    // _listRouter.add(LoginRouter());
    void initRouter(IRouterProvider routerProvider) {
      routerProvider.initRouter(router);
    }
    _listRouter.forEach(initRouter);
  }
}
