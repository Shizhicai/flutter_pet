import 'package:common_utils/common_utils.dart';
import 'package:flutter_pet/base/base_page_presenter.dart';
import 'package:flutter_pet/net/api.dart';
import 'package:flutter_pet/net/dio_utils.dart';
import 'package:flutter_pet/page/login/iview/login_iview.dart';
import 'package:flutter_pet/type/code_type.dart';
import 'package:oktoast/oktoast.dart';

class LoginPagePresenter extends BasePagePresenter<LoginIMvpView> {
  /// 获取验证码
  Future<bool> sendCode(String phone) async {
    final Map<String, dynamic> params = <String, String>{};
    params['phone'] = phone;
    params['type'] = CodeType.LOGIN.value;
    bool? state = await requestNetwork<bool?>(
      Method.post,
      url: Api.sendCode,
      params: params,
      onSuccess: (data) {
        if (data == true) {
          showToast("发送成功");
        }
      },
    );
    return state ?? false;
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
