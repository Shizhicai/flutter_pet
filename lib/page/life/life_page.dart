import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet/res/colours.dart';

class LifePage extends StatefulWidget {
  const LifePage({Key? key}) : super(key: key);

  @override
  _LifePageState createState() => _LifePageState();
}

class _LifePageState extends State<LifePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Life页面',
        style: TextStyle(
            color: Colours.color_222,
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
