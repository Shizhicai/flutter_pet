import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/base/base_page.dart';
import 'package:flutter_pet/common/common_iview.dart';
import 'package:flutter_pet/page/login/presenter/find_pwd_presenter.dart';
import 'package:flutter_pet/page/login/presenter/set_pwd_presenter.dart';
import 'package:flutter_pet/res/Colours.dart';
import 'package:flutter_pet/res/gaps.dart';
import 'package:flutter_pet/routers/fluro_navigator.dart';
import 'package:flutter_pet/widget/change_notifier_manage.dart';
import 'package:flutter_pet/widget/common_button.dart';
import 'package:flutter_pet/widget/div_app_bar.dart';
import 'package:flutter_pet/widget/input_text_field.dart';

class SetPwdPage extends StatefulWidget {
  const SetPwdPage({Key? key, required this.code, required this.phone})
      : super(key: key);
  final String code;
  final String phone;

  @override
  _SetPwdPageState createState() => _SetPwdPageState();
}

class _SetPwdPageState extends State<SetPwdPage>
    with BasePageMixin<SetPwdPage, SetPwdPresenter>, ChangeNotifierMixin {
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _rePwdController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier?, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _pwdController: callbacks,
      _rePwdController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  // 校验
  void _verify() {
    final String name = _pwdController.text;
    final String password = _rePwdController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 6) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
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
                "设置新密码",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colours.color_222,
                  fontSize: 22,
                ),
              ),
              Gaps.vGap50,
              InputTextField(
                isPwd:true,
                controller: _pwdController,
                hintText: '密码不少于8位，必须包含数字、字母',
                maxLength: 20,
                keyboardType: TextInputType.text,
                focusNode: _nodeText1,
              ),
              InputTextField(
                isPwd:true,
                controller: _rePwdController,
                hintText: '请再次输入密码',
                focusNode: _nodeText2,
                maxLength: 20,
                keyboardType: TextInputType.text,
              ),
              Gaps.vGap35,
              CommonButton(
                onPressed: _clickable ? _changePwd : () {},
                text: '确认',
                isClick: _clickable,
                isWidgetAll: false,
              )
            ],
          ),
        ));
  }

  void _changePwd() {
    String pwdStr = _pwdController.text.toString();
    String rePwdStr = _rePwdController.text.toString();
    if (pwdStr != rePwdStr) {
      showToast('两次密码不相同，请重新输入');
      return;
    }
    presenter?.setPwd(widget.phone, widget.code, pwdStr);
  }

  @override
  SetPwdPresenter createPresenter() {
    return SetPwdPresenter();
  }
}
