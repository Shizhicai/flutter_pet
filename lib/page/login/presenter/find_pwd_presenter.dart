import 'package:flutter_pet/base/base_page_presenter.dart';
import 'package:flutter_pet/net/api.dart';
import 'package:flutter_pet/type/code_type.dart';
import 'package:oktoast/oktoast.dart';

import '../login_router.dart';

class FindPwdPresenter extends BasePagePresenter {
  /// 获取验证码
  Future<bool> sendCode(String phone) async {
    final Map<String, dynamic> params = <String, String>{};
    params['phone'] = phone;
    params['type'] = CodeType.FIND_PASSWORD.value;
    String api = Api.sendCode;
    bool? state = await requestNetwork<bool?>(
      url: api,
      params: params,
      onSuccess: (data) {
        if (data == true) {
          showToast("发送成功");
        }
      },
    );
    return state ?? false;
  }

  void checkCode(String phone, String code) {
    final Map<String, dynamic> params = <String, String>{};
    params['phone'] = phone;
    params['code'] = code;
    params['type'] = CodeType.FIND_PASSWORD.value;
    asyncRequestNetwork<Map<String, dynamic>>(
        url: Api.checkCode,
        queryParameters: params,
        onSuccess: (data) {
          String result = data!['result'];
          view.jumpPage(LoginRouter.loginSetPwdPage,
              arguments: {'code': result, 'phone': phone});
        });
  }
}
