import 'package:flutter_pet/base/base_page_presenter.dart';
import 'package:flutter_pet/net/api.dart';

class FirstInputInfoPresenter extends BasePagePresenter {
  void saveUserInfo(String imgPath, String name, String birthday, int sex) {
    final Map<String, dynamic> params = <String, String>{};
    params["avatar"] = imgPath;
    params["birthday"] = birthday;
    params["nickName"] = name;
    params["sex"] = sex;
    requestNetwork<void>(
        url: Api.editUserInfo,
        params: params,
        onSuccess: (data) {
          // 提交成功
        });
  }
}
