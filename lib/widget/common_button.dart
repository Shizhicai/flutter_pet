import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/res/Colours.dart';
import 'package:flutter_pet/res/dimens.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {Key? key,
      this.text = '',
      this.fontSize = Dimens.font_sp16,
      this.textColor,
      this.disabledTextColor,
      this.minHeight = 48.0,
      this.minWidth = double.infinity,
      required this.onPressed,
      this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
      this.radius = 24.0,
      // this.side = BorderSide.none,
      this.isThemeBtn = true,
      this.isClick = true})
      : super(key: key);

  final String text;
  final double fontSize;
  final Color? textColor;
  final Color? disabledTextColor;
  final double? minHeight;
  final double? minWidth;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double radius;

  // final BorderSide side;
  final bool isThemeBtn;
  final bool isClick;

  @override
  Widget build(BuildContext context) {
    List<Color> colors = isClick
        ? [Colours.theme_state, Colours.theme_end]
        : [Colours.color_999, Colours.color_999];
    return GestureDetector(
      child: Container(
        height: minHeight,
        child: Text(text,
            style: TextStyle(
                fontSize: fontSize,
                color: Colors.white)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(colors: colors)),
        padding: padding,
      ),
      onTap: onPressed,
    );
  }
}
