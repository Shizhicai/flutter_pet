import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pet/utils/toast_utils.dart';

class DoubleTapBackExitApp extends StatefulWidget {
  const DoubleTapBackExitApp(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 2500)})
      : super(key: key);

  final Widget child;
  final Duration duration;

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();
}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime? _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() async {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > widget.duration) {
      _lastTime = DateTime.now();
      Toast.show('再次点击退出应用');
      return Future.value(false);
    }
    Toast.cancelToast();
    await SystemNavigator.pop();
    return Future.value(true);
  }
}
