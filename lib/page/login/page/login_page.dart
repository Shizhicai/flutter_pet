import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pet/base/base_page.dart';
import 'package:flutter_pet/common/constant.dart';
import 'package:flutter_pet/page/login/presenter/login_presenter.dart';
import 'package:flutter_pet/res/colours.dart';
import 'package:flutter_pet/res/gaps.dart';
import 'package:flutter_pet/routers/fluro_navigator.dart';
import 'package:flutter_pet/utils/other_utils.dart';
import 'package:flutter_pet/widget/change_notifier_manage.dart';
import 'package:flutter_pet/widget/common_button.dart';
import 'package:flutter_pet/widget/div_app_bar.dart';
import 'package:flutter_pet/widget/input_text_field.dart';

import '../login_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with
        BasePageMixin<LoginPage, LoginPagePresenter>,
        ChangeNotifierMixin<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  int _mode = modeCode; // 0 验证码登录  1 密码登录
  static const int modeCode = 0;
  static const int modePwd = 1;

  @override
  Map<ChangeNotifier?, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _codeController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      /// 显示状态栏和导航栏
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
    _nameController.text = SpUtil.getString(Constant.spPhone) ?? '';
  }

  // 校验
  void _verify() {
    final String name = _nameController.text;
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

  void _checkLoginMode() {
    setState(() {
      if (_mode == modeCode) {
        _mode = modePwd;
      } else {
        _mode = modeCode;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String actionName;
    String title;
    String titleHint;
    String inputHint;
    String btnName;
    if (_mode == modeCode) {
      actionName = '密码登陆';
      title = '手机号登录/注册';
      titleHint = '未注册的手机号验证后自动创建账号';
      inputHint = '请输入验证码';
      btnName = '获取验证码';
    } else {
      actionName = '验证码登录';
      title = '密码登录';
      titleHint = ' ';
      inputHint = '请输入密码';
      btnName = '忘记密码';
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DivAppBar(
            isBack: false,
            actionName: actionName,
            onPressed: () => _checkLoginMode(),
          ),
          Gaps.vGap35,
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colours.color_222,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Gaps.vGap10,
                  Text(
                    titleHint,
                    style: const TextStyle(
                      color: Colours.color_999,
                      fontSize: 15,
                    ),
                  ),
                  Gaps.vGap35,
                  InputTextField(
                    focusNode: _nodeText1,
                    controller: _nameController,
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    hintText: '请输入手机号',
                  ),
                  InputTextField(
                    focusNode: _nodeText2,
                    controller: _codeController,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    hintText: inputHint,
                    btnName: btnName,
                    getVCode: () {
                      if (_mode == modeCode) {
                        if (_nameController.text.isNotEmpty &&
                            _nameController.text.length == 11) {
                          return presenter!.sendCode(_nameController.text);
                        } else {
                          showToast("请输入正确的手机号");
                          return Future<bool>.value(false);
                        }
                      } else {
                        NavigatorUtils.push(
                            context, LoginRouter.loginFindPwdPage);
                        return Future<bool>.value(false);
                      }
                    },
                  ),
                  Gaps.vGap50,
                  CommonButton(
                    isClick: _clickable,
                    onPressed: _clickable ? _login : null,
                    text: '登陆',
                    isWidgetAll: false,
                  ),
                  Gaps.vGap20,
                  _buildTextHint(),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildTextHint() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          const TextSpan(
            text: '点击登录即表示您已阅读并同意',
            style: TextStyle(color: Colours.color_999, fontSize: 13),
          ),
          TextSpan(
              text: '《服务协议》',
              style: const TextStyle(color: Colours.color_theme, fontSize: 13),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  jumpWeb("服务协议", Constant.htmlUserProtocol);
                }),
          const TextSpan(
            text: '和',
            style: TextStyle(color: Colours.color_999, fontSize: 13),
          ),
          TextSpan(
              text: '《隐私政策》',
              style: const TextStyle(color: Colours.color_theme, fontSize: 13),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  jumpWeb("隐私政策", Constant.htmlUserProtocol);
                }),
        ]));
  }

  void jumpWeb(String title, String url) {
    NavigatorUtils.goWebViewPage(context, title, url);
  }

  void _login() {
    String phone = _nameController.text;
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
    presenter?.login(phone, code: code);
  }

  @override
  LoginPagePresenter createPresenter() {
    return LoginPagePresenter();
  }
}
