import 'package:common_utils/common_utils.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_pet/base/base_page.dart';
import 'package:flutter_pet/page/login/presenter/first_input_pet_presenter.dart';
import 'package:flutter_pet/res/colours.dart';
import 'package:flutter_pet/res/gaps.dart';
import 'package:flutter_pet/widget/change_notifier_manage.dart';
import 'package:flutter_pet/widget/common_button.dart';
import 'package:flutter_pet/widget/div_app_bar.dart';
import 'package:flutter_pet/widget/input_text_field.dart';
import 'package:flutter_pet/widget/load_image.dart';

class FirstInputPetPage extends StatefulWidget {
  const FirstInputPetPage({Key? key}) : super(key: key);

  @override
  _FirstInputPetPageState createState() => _FirstInputPetPageState();
}

class _FirstInputPetPageState extends State<FirstInputPetPage>
    with
        BasePageMixin<FirstInputPetPage, FirstInputPetPresenter>,
        ChangeNotifierMixin<FirstInputPetPage> {
  final TextEditingController _nameController = TextEditingController(); // 用户名
  final FocusNode _nodeText = FocusNode();
  final ValueNotifier<String?> petType = ValueNotifier(null); // 类型
  final ValueNotifier<String> birthday = ValueNotifier(""); // 生日
  final ValueNotifier<int> sex = ValueNotifier(-1); // 性别
  bool _clickable = false; // 是否可以点击

  @override
  Map<ChangeNotifier?, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _nodeText: null,
      sex: callbacks,
      birthday: callbacks,
      petType: callbacks
    };
  }

  void _verify() {
    bool clickable = true;
    // if (TextUtil.isEmpty(imgPath.value)) {
    //   clickable = false;
    // }
    if (TextUtil.isEmpty(_nameController.text)) {
      clickable = false;
    }
    if (TextUtil.isEmpty(birthday.value)) {
      clickable = false;
    }
    if (sex.value == -1) {
      clickable = false;
    }
    print("调用校验方法");
    setState(() {
      _clickable = clickable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DivAppBar(
        actionName: '跳过',
        onPressed: () {},
      ),
      body: _buildWidget(context),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 30,
          right: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "填写宠物信息",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Gaps.vGap32,
              Center(
                child: GestureDetector(
                  onTap: () => _openImg(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 33),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey),
                    child: const LoadAssetImage("logo"),
                  ),
                ),
              ),
              Gaps.vGap50,
              // 名称
              InputTextField(
                controller: _nameController,
                hintText: "请输入昵称",
                maxLength: 10,
                isNickName: true,
                focusNode: _nodeText,
              ),
              // 宠物类型
              GestureDetector(
                onTap: ()=>{

                },
                child: SizedBox(
                  height: 56,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      petType.value ?? "请选宠物",
                      style: TextStyle(
                          fontSize: 16,
                          color: petType.value == null
                              ? Colours.color_999
                              : Colours.color_222),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colours.color_eee,
                height: 0.8,
              ),
              // 生日选择
              DateTimePicker(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.8,
                    ),
                  ),
                  hintText: '选择生日',
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colours.color_eee,
                      width: 0.8,
                    ),
                  ),
                ),
                dateMask: 'yyyy-MM-dd',
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                calendarTitle: "选择日期",
                cancelText: "取消",
                confirmText: "确定",
                onChanged: (val) => birthday.value = val,
              ),
              // 宠物性别
              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => sex.value = 0,
                        child: SizedBox(
                          child: Row(
                            children: [
                              LoadAssetImage(
                                sex.value == 0
                                    ? "login/ic_man_select"
                                    : "login/ic_man_normal",
                                width: 18,
                                height: 18,
                              ),
                              Gaps.hGap4,
                              Text(
                                "GG",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: sex.value == 0
                                        ? Colours.color_3581FF
                                        : Colours.color_999),
                              )
                            ],
                          ),
                          height: 54,
                        ),
                      ),
                      Gaps.hGap12,
                      GestureDetector(
                        onTap: () => sex.value = 1,
                        child: SizedBox(
                          child: Row(
                            children: [
                              LoadAssetImage(
                                sex.value == 1
                                    ? "login/ic_woman_select"
                                    : "login/ic_woman_normal",
                                width: 18,
                                height: 18,
                              ),
                              Gaps.hGap4,
                              Text(
                                "MM",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: sex.value == 1
                                        ? Colours.color_ff8772
                                        : Colours.color_999),
                              )
                            ],
                          ),
                          height: 54,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0.8,
                    color: Colours.color_eee,
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
            bottom: 34,
            left: 30,
            right: 30,
            child: CommonButton(
              isWidgetAll: false,
              text: "下一步",
              onPressed: _clickable ? _saveInfo : () {},
              isClick: _clickable,
            ))
      ],
    );
  }

  _saveInfo() {}

  _openImg() {}

  @override
  FirstInputPetPresenter createPresenter() => FirstInputPetPresenter();
}
