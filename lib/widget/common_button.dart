import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/res/colours.dart';
import 'package:flutter_pet/res/dimens.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    this.text = '',
    this.fontSize = Dimens.font_sp16,
    this.textColor = Colors.white,
    this.disabledTextColor = Colours.color_999,
    this.minHeight = 48.0,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius = 24.0,
    // this.side = BorderSide.none,
    this.isThemeBtn = true,
    this.isClick = true,
    this.isWidgetAll = true,
    this.isShowBorder = false,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color textColor;
  final Color disabledTextColor;
  final double? minHeight;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool isWidgetAll;
  final bool isThemeBtn;
  final bool isClick;
  final bool isShowBorder;

  @override
  Widget build(BuildContext context) {
    List<Color> colors;
    Color borderColor;
    double horizontalSize;
    if (isThemeBtn) {
      horizontalSize = 10;
      borderColor = Colors.transparent;
      colors = isClick
          ? [Colours.theme_state, Colours.theme_end]
          : [Colours.color_eee, Colours.color_eee];
    } else {
      if (isShowBorder) {
        horizontalSize = 10;
        borderColor = isClick ? Colours.color_222 : Colours.color_c0c0c0;
      } else {
        horizontalSize = 0;
        borderColor = Colors.transparent;
      }
      colors = [Colors.transparent, Colors.transparent];
    }

    return GestureDetector(
        onTap: onPressed,
        child: Container(
            alignment: Alignment.center,
            height: minHeight,
            padding: EdgeInsets.symmetric(horizontal: horizontalSize),
            decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1),
                gradient: LinearGradient(colors: colors), // 渐变色
                borderRadius: BorderRadius.circular(radius)),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: isWidgetAll ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        color: isClick ? textColor : disabledTextColor,
                        fontSize: fontSize),
                  ),
                ])));
  }
}
