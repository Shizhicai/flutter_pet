import 'package:fluro/fluro.dart';
import 'package:flutter_pet/page/login/page/find_pwd_page.dart';
import 'package:flutter_pet/page/login/page/login_page.dart';
import 'package:flutter_pet/page/login/page/set_pwd_page.dart';
import 'package:flutter_pet/routers/i_router.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = '/login';
  static String loginFindPwdPage = '/login/findPwd';
  static String loginSetPwdPage = '/login/setPwd';

  @override
  void initRouter(FluroRouter router) {
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, __) => const LoginPage()));
    router.define(loginFindPwdPage,
        handler: Handler(handlerFunc: (_, __) => const FindPwdPage()));
    router.define(loginSetPwdPage,
        handler: Handler(handlerFunc: (_,Map<String, List<String>> params)
    {
      final String code = params['code']?.first ?? '';
      final String phone = params['phone']?.first ?? '';
      return SetPwdPage(code: code, phone: phone,);
    });
  }
}
