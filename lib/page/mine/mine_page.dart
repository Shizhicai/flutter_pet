import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet/res/colours.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Mine页面',
        style: TextStyle(
            color: Colours.color_222,
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
