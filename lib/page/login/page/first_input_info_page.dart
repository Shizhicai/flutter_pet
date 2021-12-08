import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/widget/div_app_bar.dart';

class FirstInputInfoPage extends StatefulWidget {
  const FirstInputInfoPage({Key? key}) : super(key: key);

  @override
  _FirstInputInfoPageState createState() => _FirstInputInfoPageState();
}

class _FirstInputInfoPageState extends State<FirstInputInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DivAppBar(

      ),
    );
  }
}
