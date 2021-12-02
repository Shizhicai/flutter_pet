import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/widget/load_image.dart';

class StateLayout extends StatelessWidget {
  const StateLayout({Key? key, required this.type, this.hintText})
      : super(key: key);
  final StateType type;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (type == StateType.loading)
          const CupertinoActivityIndicator(radius: 16.0)
        else
          Opacity(
            opacity: /*context.isDark ? 0.5 :*/ 1,
            child: LoadAssetImage(
              'state/${type.img}',
              width: 120,
            ),
          ),
        const SizedBox(
          width: double.infinity,
          height: 16,
        ),
        Text(
          hintText ?? type.hintText,
          style:
              Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14.0),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

enum StateType {
  /// 加载中
  loading,
  /// 空
  empty,
  /// 消息
  message,
  /// 无网络
  network,
}

extension StateTypeExtension on StateType {
  String get img => <String>['', 'not_data', 'not_message', 'not_network'][index];

  String get hintText => <String>['加载中...', '暂无数据', '暂无消息', '无网络连接'][index];
}
