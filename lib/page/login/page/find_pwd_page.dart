import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/base/base_page.dart';
import 'package:flutter_pet/common/common_iview.dart';
import 'package:flutter_pet/page/login/login_router.dart';
import 'package:flutter_pet/page/login/presenter/find_pwd_presenter.dart';
import 'package:flutter_pet/res/Colours.dart';
import 'package:flutter_pet/res/gaps.dart';
import 'package:flutter_pet/routers/fluro_navigator.dart';
import 'package:flutter_pet/utils/other_utils.dart';
import 'package:flutter_pet/widget/change_notifier_manage.dart';
import 'package:flutter_pet/widget/common_button.dart';
import 'package:flutter_pet/widget/div_app_bar.dart';
import 'package:flutter_pet/widget/input_text_field.dart';

class FindPwdPage extends StatefulWidget {
  const FindPwdPage({Key? key}) : super(key: key);

  @override
  _FindPwdPageState createState() => _FindPwdPageState();
}

class _FindPwdPageState extends State<FindPwdPage>
    with BasePageMixin<FindPwdPage, FindPwdPresenter>, ChangeNotifierMixin {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier?, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _phoneController: callbacks,
      _codeController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  // 校验
  void _verify() {
    final String name = _phoneController.text;
    final String password = _codeController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 4) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DivAppBar(
          isBack: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.vGap16,
              const Text(
                "手机号找回密码",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colours.color_222,
                  fontSize: 22,
                ),
              ),
              Gaps.vGap50,
              InputTextField(
                controller: _phoneController,
                hintText: '请输入手机号',
                maxLength: 11,
                keyboardType: TextInputType.phone,
                focusNode: _nodeText1,
              ),
              InputTextField(
                controller: _codeController,
                hintText: '请输入验证码',
                focusNode: _nodeText2,
                maxLength: 4,
                keyboardType: TextInputType.number,
                btnName: '获取验证码',
                getVCode: () {
                  if (_phoneController.text.isNotEmpty &&
                      _phoneController.text.length == 11) {
                    return presenter!.sendCode(_phoneController.text);
                  } else {
                    showToast("请输入正确的手机号");
                    return Future<bool>.value(false);
                  }
                },
              ),
              Gaps.vGap35,
              CommonButton(
                onPressed: _clickable ? _checkCode : () {},
                text: '下一步',
                isClick: _clickable,
                isWidgetAll: false,
              )
            ],
          ),
        ));
  }

  void _checkCode() {
    String phone = _phoneController.text;
    if (phone.isEmpty) {
      showToast('请输入手机号');
      return;
    }
    if (!phone.checkPhone()) {
      showToast('请输入正确的手机号');
      return;
    }
    String code = _codeController.text;
    if (code.isEmpty) {
      showToast('请输入验证码');
      return;
    }
    if (code.length != 4) {
      showToast('请输入正确的验证码');
      return;
    }
    presenter?.checkCode(phone, code);
  }

  @override
  FindPwdPresenter createPresenter() {
    return FindPwdPresenter();
  }

  @override
  void jumpSetPwdPage(String code, String phone) {
    NavigatorUtils.push(
      context,
      '${LoginRouter.loginSetPwdPage}?code=$code&phone=$phone',
    );
  }
}
