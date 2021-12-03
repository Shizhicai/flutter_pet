import 'package:common_utils/common_utils.dart';
import 'package:flutter_pet/base/base_page_presenter.dart';
import 'package:flutter_pet/net/api.dart';
import 'package:flutter_pet/net/dio_utils.dart';
import 'package:flutter_pet/page/login/iview/login_iview.dart';
import 'package:flutter_pet/type/code_type.dart';

class LoginPagePresenter extends BasePagePresenter<LoginIMvpView> {
  /// 获取验证码
  void sendCode(String phone) {
    final Map<String, String> params = <String, String>{};
    params['phone'] = phone;
    params['type'] = CodeType.LOGIN.value;
    asyncRequestNetwork<Object>(
      Method.post,
      url: Api.sendCode,
      queryParameters: params,
      onSuccess: (data) {
        print('发送成功');
      },
    );
  }

  /// 登录
  void login(String phone, {String code = '', String pwd = ''}) {
    if (code == '' && pwd == '') {
      return;
    }
    if (!TextUtil.isEmpty(code)) {
      // 验证码登录

    } else if (!TextUtil.isEmpty(pwd)) {
      // 密码登录

    }
  }
}
