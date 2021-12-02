import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet/widget/state_layout.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: MyAppBar(
      //
      // ),
      body: StateLayout(
        type: StateType.empty,
        hintText: '页面不存在',
      ),
    );
  }
}
