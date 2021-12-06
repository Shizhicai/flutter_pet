import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pet/net/dio_utils.dart';
import 'package:flutter_pet/net/intercept.dart';
import 'package:flutter_pet/page/login/page/login_page.dart';
import 'package:flutter_pet/page/not_found_page.dart';
import 'package:flutter_pet/page/splash_page.dart';
import 'package:flutter_pet/routers/routers.dart';
import 'package:flutter_pet/utils/handle_error_utils.dart';
import 'package:flutter_pet/utils/log_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_strategy/url_strategy.dart';

import 'common/constant.dart';

Future<void> main() async {
  /// 确保初始化完成
  WidgetsFlutterBinding.ensureInitialized();

  /// 去除URL中的“#”(hash)，仅针对Web。默认为setHashUrlStrategy
  /// 注意本地部署和远程部署时`web/index.html`中的base标签，https://github.com/flutter/flutter/issues/69760
  setPathUrlStrategy();

  /// sp初始化
  await SpUtil.getInstance();

  /// 隐藏状态栏。为启动页、引导页设置。完成后修改回显示状态栏。
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  handleError(() => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final Widget? home;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  MyApp({Key? key, this.home}) : super(key: key) {
    Log.init();
    initDio();
    Routes.initRoutes();
  }

  /// 初始化 Dio
  void initDio() {
    final List<Interceptor> interceptors = <Interceptor>[];

    /// 添加token验证
    interceptors.add(TokenInterceptor());

    /// 打印Log(生产模式去除)
    if (!Constant.inProduction) {
      interceptors.add(LoggingInterceptor());
    }

    /// 适配数据(根据自己的数据结构，可自行选择添加)
    // interceptors.add(AdapterInterceptor());

    configDio(
      baseUrl: Constant.baseUrl,
      interceptors: interceptors,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Providers 配置
    return OKToast(
      child: _buildMaterialApp(),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
    );
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: '主人你好',

      // showPerformanceOverlay: true, //显示性能标签
      // debugShowCheckedModeBanner: false, // 去除右上角debug的标签
      // checkerboardRasterCacheImages: true,
      // showSemanticsDebugger: true, // 显示语义视图
      // checkerboardOffscreenLayers: true, // 检查离屏渲染

      home: home ?? const LoginPage(),
      onGenerateRoute: Routes.router.generator,
      navigatorKey: navigatorKey,
      builder: (BuildContext context, Widget? child) {
        // /// 仅针对安卓
        // if (Device.isAndroid) {
        //   /// 切换深色模式会触发此方法，这里设置导航栏颜色
        //   ThemeUtils.setSystemNavigationBar(provider.getThemeMode());
        // }
        /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },

      /// 因为使用了fluro，这里设置主要针对Web
      onUnknownRoute: (_) {
        return MaterialPageRoute(
            builder: (BuildContext context) => const NotFoundPage());
      },
      restorationScopeId: 'app',
    );
  }
}
