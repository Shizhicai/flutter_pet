import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet/res/colours.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Filter页面',
        style: TextStyle(
            color: Colours.color_222,
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
