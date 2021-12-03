import 'package:flutter/material.dart';
import 'package:flutter_pet/base/base_page.dart';
import 'package:flutter_pet/page/login/iview/login_iview.dart';
import 'package:flutter_pet/page/login/presenter/login_presenter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with BasePageMixin<LoginPage, LoginPagePresenter>
    implements LoginIMvpView {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text('测试'),
        onPressed: sendCode,
      ),
    );
  }

  void sendCode() {
    presenter?.sendCode('17673237712');
  }

  @override
  LoginPagePresenter createPresenter() {
    return LoginPagePresenter();
  }
}
