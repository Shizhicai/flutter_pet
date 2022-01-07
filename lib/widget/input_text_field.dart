import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/res/colours.dart';
import 'package:flutter_pet/widget/common_button.dart';
import '../res/gaps.dart';
import 'package:flutter_pet/utils/device_utils.dart';
import 'package:flutter_pet/widget/load_image.dart';

class InputTextField extends StatefulWidget {
  const InputTextField(
      {Key? key,
      required this.controller,
      this.maxLength = 16,
      this.autoFocus = false,
      this.keyboardType = TextInputType.text,
      this.hintText = '',
      this.focusNode,
      this.isPwd = false,
      this.keyName,
      this.isNickName = false,
      this.btnName = "获取验证码",
      this.getVCode})
      : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode? focusNode;
  final bool isPwd;
  final Future<bool> Function()? getVCode;
  final String btnName;
  final bool isNickName;

  /// 用于集成测试寻找widget
  final String? keyName;

  /// 验证码
  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;

  /// 倒计时
  final int _second = 60;

  /// 当前秒数
  late int _currentSecond;
  StreamSubscription? _subscription;

  @override
  void initState() {
    /// 初始化值
    _isShowDelete = widget.controller.text.isNotEmpty;

    /// 监听输入变化
    widget.controller.addListener(isEmpty);
    super.initState();
  }

  /// 非空判断
  void isEmpty() {
    final bool isNotEmpty = widget.controller.text.isNotEmpty;
    if (isNotEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(isEmpty);
    _subscription?.cancel();
    super.dispose();
  }

  Future _getVCode() async {
    final bool isSuccess = await widget.getVCode!();
    if (isSuccess) {
      setState(() {
        _currentSecond = _second;
        _clickable = false;
      });
      _subscription = Stream.periodic(const Duration(seconds: 1), (int i) => i)
          .take(_second)
          .listen((int i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _clickable = _currentSecond < 1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Widget textField = TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: widget.isPwd && !_isShowPwd,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      // 数字、手机号限制格式为0到9， 密码限制不包含汉字
      inputFormatters: (widget.isNickName
          ? []
          : (widget.keyboardType == TextInputType.number ||
                  widget.keyboardType == TextInputType.phone)
              ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
              : [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))]),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: widget.hintText,
        counterText: '',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: themeData.primaryColor,
            width: 0.8,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colours.color_eee,
            width: 0.8,
          ),
        ),
      ),
    );

    /// 个别Android机型（华为、vivo）的密码安全键盘不弹出问题（已知小米正常），临时修复方法：https://github.com/flutter/flutter/issues/68571 (issues/61446)
    /// 怀疑是安全键盘与三方输入法之间的切换冲突问题。
    if (Device.isAndroid) {
      textField = Listener(
        onPointerDown: (e) =>
            FocusScope.of(context).requestFocus(widget.focusNode),
        child: textField,
      );
    }
    Widget? clearButton;
    if (_isShowDelete) {
      clearButton = Semantics(
        label: '清空',
        hint: '清空输入框',
        child: GestureDetector(
          child: LoadAssetImage(
            'login/ic_input_delete',
            key: Key('${widget.keyName}'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: () => widget.controller.text = '',
        ),
      );
    }
    late Widget pwdVisible;
    if (widget.isPwd) {
      pwdVisible = Semantics(
        label: '密码可见开关',
        hint: '密码是否可见',
        child: GestureDetector(
          child: LoadAssetImage(
            _isShowPwd ? 'login/ic_input_display' : 'login/ic_input_hide',
            key: Key('${widget.keyName}_showPwd'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: () {
            setState(() {
              _isShowPwd = !_isShowPwd;
            });
          },
        ),
      );
    }
    // TODO 验证码
    late Widget getVCodeButton;
    if (widget.getVCode != null) {
      getVCodeButton = CommonButton(
        minHeight: 34,
        onPressed: _clickable ? _getVCode : () {},
        text: _clickable ? widget.btnName : "($_currentSecond)s",
        isThemeBtn: false,
        fontSize: 13,
        isClick: _clickable,
        textColor: Colours.color_222,
        disabledTextColor: Colours.color_c0c0c0,
        isShowBorder: true,
      );
    }
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          textField,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// _isShowDelete参数动态变化，为了不破坏树结构使用Visibility，false时放一个空Widget。
              /// 对于其他参数，为初始配置参数，基本可以确定树结构，就不做空Widget处理。
              Visibility(
                  visible: _isShowDelete, child: clearButton ?? Gaps.empty),
              if (widget.isPwd || widget.getVCode != null) Gaps.hGap15,
              if (widget.isPwd) pwdVisible,
              if (widget.getVCode != null) getVCodeButton,
            ],
          )
        ],
      ),
    );
  }
}
