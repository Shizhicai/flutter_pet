import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/res/gaps.dart';
import 'package:flutter_pet/utils/device_utils.dart';
import 'package:flutter_pet/widget/div_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.title, required this.url})
      : super(key: key);
  final String title;
  final String url;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int _progressValue = 0;

  @override
  void initState() {
    super.initState();
    if (Device.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  Widget getWebView() {
//     if (Device.isWeb) {
//       final IFrameElement _iframeElement = IFrameElement();
//       _iframeElement.src = widget.url;
//       _iframeElement.style.border = 'none';
// // ignore: undefined_prefixed_name
//       ui.platformViewRegistry.registerViewFactory(
//         'iframeElement',
//         (int viewId) => _iframeElement,
//       );
//       Widget _iframeWidget;
//       _iframeWidget = HtmlElementView(
//         key: UniqueKey(),
//         viewType: 'iframeElement',
//       );
//       return Scaffold(
//           appBar: DivAppBar(
//             title: widget.title,
//           ),
//           body: Stack(
//             children: <Widget>[
//               IgnorePointer(
//                 ignoring: true,
//                 child: Center(
//                   child: _iframeWidget,
//                 ),
//               ),
//             ],
//           ));
//     } else {
      return FutureBuilder<WebViewController>(
        future: _controller.future, //获取数据的方法
        builder: (context, snapshot) {
          // 构建组件的策略。
          /// 导航栏拦截
          return WillPopScope(
            onWillPop: () async {
              if (snapshot.hasData) {
                final bool canGoBack = await snapshot.data!.canGoBack();
                if (canGoBack) {
                  // 网页可以返回时，优先返回上一页
                  await snapshot.data!.goBack();
                  return Future.value(false);
                }
              }
              return Future.value(true);
            },
            child: Scaffold(
              appBar: DivAppBar(
                title: widget.title,
              ),
              body: Stack(
                children: [
                  WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    allowsInlineMediaPlayback: true,
                    onWebViewCreated: (webViewController) {
                      _controller.complete(webViewController);
                    },
                    onProgress: (progress) {
                      print("webView is loading ($progress%)");
                      setState(() {
                        _progressValue = progress;
                      });
                    },
                  ),
                  if (_progressValue != 100)
                    LinearProgressIndicator(
                      value: _progressValue / 100,
                      backgroundColor: Colors.transparent,
                      minHeight: 2,
                    )
                  else
                    Gaps.empty,
                ],
              ),
            ),
          );
        },
      );
    // }
  }

  @override
  Widget build(BuildContext context) {
    //基于与Future交互的最新快照构建自己的小部件
    return getWebView();
  }
}
