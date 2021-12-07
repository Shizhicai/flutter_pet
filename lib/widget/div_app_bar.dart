import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/res/colours.dart';
import 'package:flutter_pet/res/gaps.dart';
import 'package:flutter_pet/utils/theme_utils.dart';
import 'package:flutter_pet/widget/common_button.dart';

class DivAppBar extends StatelessWidget implements PreferredSizeWidget{
  const DivAppBar(
      {Key? key,
      this.backgroundColor,
      this.title = '',
      this.backImg = 'assets/images/ic_back_black.png',
      this.actionName = '',
      this.actionImg = '',
      this.onPressed,
      this.isBack = true,
      this.isThemeActionBtn = false,
      this.actionSize = 16})
      : super(key: key);

  final Color? backgroundColor;
  final String title;
  final String backImg;
  final String actionName;
  final double actionSize;
  final String actionImg;
  final VoidCallback? onPressed;
  final bool isBack;
  final bool isThemeActionBtn;

  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor = backgroundColor ?? context.backgroundColor;
    final SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle.light;
    final Widget back = isBack
        ? IconButton(
            onPressed: () async {
              /// 关闭软键盘
              FocusManager.instance.primaryFocus?.unfocus();
              final isBack = await Navigator.maybePop(context);
              if (!isBack) {
                await SystemNavigator.pop();
              }
            },
            icon: Image.asset(
              backImg,
            ),
            padding: const EdgeInsets.all(12.0),
          )
        : Gaps.empty;

    Widget action;
    if (actionName.isNotEmpty) {
      action = Positioned(
        right: 0.0,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: CommonButton(
            onPressed: onPressed ?? () {},
            text: actionName,
            isThemeBtn: isThemeActionBtn,
            isWidgetAll: false,
            textColor: Colours.color_222,
            fontSize: actionSize,
          ),
        ),
      );
      /*}else if(actionImg.isNotEmpty){
*/
    }else{
      action = Gaps.empty;
    }

    Widget titleWidget = Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colours.color_222),
      ),
    );
    return AnnotatedRegion(
        child: Material(
          color: _backgroundColor,
            child: SafeArea(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [titleWidget, back, action],
            ),
          ),
        ),
        value: _overlayStyle);
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
