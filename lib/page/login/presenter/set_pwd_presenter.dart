import 'package:flutter_pet/base/base_page_presenter.dart';
import 'package:flutter_pet/net/api.dart';
import 'package:flutter_pet/page/login/login_router.dart';
import 'package:oktoast/oktoast.dart';

class SetPwdPresenter extends BasePagePresenter {
  void setPwd(String phone, String key, String pwd) {
    Map<String, dynamic> params = <String, String>{};
    params['key'] = key;
    params['phone'] = phone;
    params['newPassword'] = pwd;
    asyncRequestNetwork<Object>(
        url: Api.setPwd,
        params: params,
        onSuccess: (data) {
          showToast('修改成功');
          view.jumpPage(LoginRouter.loginPage, clearStack: true);
        });
  }
}
