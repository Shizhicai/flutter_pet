import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pet/net/dio_utils.dart';
import 'package:flutter_pet/net/intercept.dart';
import 'package:flutter_pet/utils/handle_error_utils.dart';
import 'package:flutter_pet/utils/log_utils.dart';
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
  MyApp({Key? key}) : super(key: key) {
    Log.init();
    initDio();
  }

  void initDio() {
    final List<Interceptor> interceptors = <Interceptor>[];

    /// 添加token验证
    interceptors.add(TokenInterceptor());

    /// 打印Log(生产模式去除)
    if (!Constant.inProduction) {
      interceptors.add(LoggingInterceptor());
    }

    /// 适配数据(根据自己的数据结构，可自行选择添加)
    interceptors.add(AdapterInterceptor());

    configDio(
      baseUrl: Constant.baseUrl,
      interceptors: interceptors,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
