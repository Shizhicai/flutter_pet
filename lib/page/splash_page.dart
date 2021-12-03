import 'dart:async';

import 'package:desktop_window/desktop_window.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/common/constant.dart';
import 'package:flutter_pet/routers/fluro_navigator.dart';
import 'package:flutter_pet/utils/device_utils.dart';
import 'package:flutter_pet/utils/image_utils.dart';
import 'package:flutter_pet/utils/theme_utils.dart';
import 'package:flutter_pet/utils/toast_utils.dart';
import 'package:flutter_pet/widget/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:rxdart/rxdart.dart';

import 'login/login_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  final List<String> _guideList = ['guide_1', 'guide_2', 'guide_3', 'guide_4'];
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      await Device.initDeviceInfo();
      if (SpUtil.getBool(Constant.spShowGuide, defValue: true)!) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        void _precacheImage(String image) {
          precacheImage(ImageUtils.getAssetImage(image), context);
        }

        _guideList.forEach(_precacheImage);
      }
      _initSplash();
    });
    if (Device.isDesktop) {
      DesktopWindow.setWindowSize(const Size(400, 800));
    }
  }

  void _initSplash() {
    _subscription =
        Stream.value(1).delay(const Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.spShowGuide, defValue: true)! ||
          Constant.isDriverTest) {
        SpUtil.putBool(Constant.spShowGuide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.backgroundColor,
      child: _status == 0
          ? const FractionallyAlignedSizedBox(
              heightFactor: 0.3,
              widthFactor: 0.33,
              leftFactor: 0.33,
              topFactor: 0.3,
              child: LoadAssetImage("logo"),
            )
          : Swiper(
              key: const Key('swiper'),
              loop: false,
              itemBuilder: (BuildContext context, int index) {
                return LoadAssetImage(
                  _guideList[index],
                  key: Key(_guideList[index]),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
              itemCount: _guideList.length,
              onTap: (int index) {
                if (index == _guideList.length - 1) {
                  _goLogin();
                }
              },
            ),
    );
  }
}
