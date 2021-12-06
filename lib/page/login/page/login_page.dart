import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pet/base/base_page.dart';
import 'package:flutter_pet/common/constant.dart';
import 'package:flutter_pet/page/login/iview/login_iview.dart';
import 'package:flutter_pet/page/login/presenter/login_presenter.dart';
import 'package:flutter_pet/res/Colours.dart';
import 'package:flutter_pet/res/gaps.dart';
import 'package:flutter_pet/widget/change_notifier_manage.dart';
import 'package:flutter_pet/widget/common_button.dart';
import 'package:flutter_pet/widget/input_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with
        BasePageMixin<LoginPage, LoginPagePresenter>,
        ChangeNotifierMixin<LoginPage>
    implements LoginIMvpView {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier?, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _passwordController: callbacks,
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
    final String password = _passwordController.text;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: const Text(
                "验证码登陆",
                style: TextStyle(color: Colours.color_222, fontSize: 16),
              ),
              onTap: () {
                showToast("验证码登陆");
              },
            ),
          ),
          Gaps.vGap35,
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "手机号登录/注册",
                    style: TextStyle(
                        color: Colours.color_222,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Gaps.vGap10,
                  const Text(
                    "未注册的手机号验证后自动创建账号",
                    style: TextStyle(
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
                    controller: _passwordController,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    hintText: '请输入验证码',
                    getVCode: () {
                      if (_nameController.text.isNotEmpty &&
                          _nameController.text.length == 11) {
                        return presenter!.sendCode(_nameController.text);
                      } else {
                        showToast("请输入正确的手机号");
                        return Future<bool>.value(false);
                      }
                    },
                  ),
                  Gaps.vGap50,
                  // CommonButton(
                  //   isClick: _clickable,
                  //   onPressed: _clickable ? _login : null,
                  //   text: '登陆',
                  // )
                  gradientButton()
                ],
              )),
        ],
      ),
    );
  }

  // 渐变色按钮
  Widget gradientButton() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.red]),// 渐变色
          borderRadius: BorderRadius.circular(25)
      ),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        color: Colors.transparent, // 设为透明色
        elevation: 0, // 正常时阴影隐藏
        highlightElevation: 0, // 点击时阴影隐藏
        onPressed: (){},
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text('登 录', style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }

  void _login() {
    showToast("登陆操作");
    // presenter?.login(phone);
  }

  @override
  LoginPagePresenter createPresenter() {
    return LoginPagePresenter();
  }
}
