import 'package:flutter_pet/base/base_page_presenter.dart';
import 'package:flutter_pet/net/api.dart';
import 'package:flutter_pet/net/dio_utils.dart';
import 'package:flutter_pet/page/login/iview/find_pwd_iview.dart';
import 'package:flutter_pet/type/code_type.dart';
import 'package:oktoast/oktoast.dart';

class FindPwdPresenter extends BasePagePresenter<FindPwdIMvpView> {
  /// 获取验证码
  Future<bool> sendCode(String phone) async {
    final Map<String, dynamic> params = <String, String>{};
    params['phone'] = phone;
    params['type'] = CodeType.FIND_PASSWORD.value;
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

  void checkCode(String phone, String code) {
    final Map<String, dynamic> params = <String, String>{};
    params['phone'] = phone;
    params['code'] = code;
    params['type'] = CodeType.FIND_PASSWORD.value;
    asyncRequestNetwork<Map<String, dynamic>>(Method.get,
        url: Api.checkCode, queryParameters: params, onSuccess: (data) {
      String result = data!['result'];
      view.jumpSetPwdPage(result, phone);
    });
  }
}
