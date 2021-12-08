import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet/res/colours.dart';

class PlazaPage extends StatefulWidget {
  const PlazaPage({Key? key}) : super(key: key);

  @override
  _PlazaPageState createState() => _PlazaPageState();
}

class _PlazaPageState extends State<PlazaPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Plaza页面',
        style: TextStyle(
            color: Colours.color_222,
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
