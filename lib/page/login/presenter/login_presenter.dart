import 'package:flustars/flustars.dart';
import 'package:flutter_pet/base/base_page_presenter.dart';
import 'package:flutter_pet/common/constant.dart';
import 'package:flutter_pet/entity/login_entity.dart';
import 'package:flutter_pet/net/api.dart';
import 'package:flutter_pet/routers/routers.dart';
import 'package:flutter_pet/type/code_type.dart';
import 'package:oktoast/oktoast.dart';

class LoginPagePresenter extends BasePagePresenter {
  /// 获取验证码
  Future<bool> sendCode(String phone) async {
    final Map<String, dynamic> params = <String, String>{};
    params['phone'] = phone;
    params['type'] = CodeType.LOGIN.value;
    bool? state = await requestNetwork<bool?>(
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
    final Map<String, dynamic> params = <String, dynamic>{};
    params['code'] = code;
    params['phone'] = phone;
    params['thirdBindId'] = '';
    asyncRequestNetwork<LoginEntity>(
        url: Api.loginCode,
        params: params,
        onSuccess: (data) {
          print("${data!.toJson()}");
          SpUtil.putString(Constant.spToken, data.token);
          SpUtil.putObject(Constant.spLoginEntity, data.toJson());
          view.jumpPage(Routes.home, clearStack: true);
        });
  }
}
