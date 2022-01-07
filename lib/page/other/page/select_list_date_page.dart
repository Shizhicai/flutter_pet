import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet/base/base_page.dart';
import 'package:flutter_pet/page/other/presenter/select_list_data_presenter.dart';
import 'package:flutter_pet/res/colours.dart';
import 'package:flutter_pet/res/gaps.dart';
import 'package:flutter_pet/widget/div_app_bar.dart';

class SelectListDataPage extends StatefulWidget {
  const SelectListDataPage(
      {Key? key,
      required this.type,
      this.singleSelect = true,
      required this.title})
      : super(key: key);
  final String type;
  final String title;
  final bool singleSelect;
  static const String TYPE_PET = "pet";
  static const String TYPE_BUDDY = "buddy";

  @override
  _SelectListDataPageState createState() => _SelectListDataPageState();
}

class _SelectListDataPageState extends State<SelectListDataPage>
    with BasePageMixin<SelectListDataPage, SelectListDataPresenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DivAppBar(
        title: widget.title,
        actionName: widget.singleSelect ? "" : "确定",
        onPressed: widget.singleSelect ? null : () => {},
      ),
      body: _buildDataList(),
      backgroundColor: Colours.color_f5f5f5,
    );
  }

  @override
  void initState() {
    super.initState();
    print(presenter == null);
    print("====");
    presenter?.getList(widget.type);
  }

  Widget _buildDataList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.line,
      ],
    );
  }

  @override
  SelectListDataPresenter createPresenter() => SelectListDataPresenter();
}
