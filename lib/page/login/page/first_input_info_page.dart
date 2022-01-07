import 'package:common_utils/common_utils.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pet/base/base_page.dart';
import 'package:flutter_pet/page/login/presenter/first_input_info_presenter.dart';
import 'package:flutter_pet/res/colours.dart';
import 'package:flutter_pet/res/gaps.dart';
import 'package:flutter_pet/routers/routers.dart';
import 'package:flutter_pet/widget/change_notifier_manage.dart';
import 'package:flutter_pet/widget/common_button.dart';
import 'package:flutter_pet/widget/div_app_bar.dart';
import 'package:flutter_pet/widget/input_text_field.dart';
import 'package:flutter_pet/widget/load_image.dart';

class FirstInputInfoPage extends StatefulWidget {
  const FirstInputInfoPage({Key? key}) : super(key: key);

  @override
  _FirstInputInfoPageState createState() => _FirstInputInfoPageState();
}

class _FirstInputInfoPageState extends State<FirstInputInfoPage>
    with
        BasePageMixin<FirstInputInfoPage, FirstInputInfoPresenter>,
        ChangeNotifierMixin<FirstInputInfoPage> {
  final TextEditingController _nameController = TextEditingController(); // 用户名
  final ValueNotifier<String> imgPath = ValueNotifier(""); // 图片
  final ValueNotifier<int> sex = ValueNotifier(-1); // 性别
  final ValueNotifier<String> birthday = ValueNotifier(""); // 生日
  final FocusNode _nodeText = FocusNode();
  bool _clickable = false; // 是否可以点击

  @override
  Map<ChangeNotifier?, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      imgPath: callbacks,
      sex: callbacks,
      birthday: callbacks,
      _nodeText: null
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DivAppBar(
        actionName: "跳过",
        onPressed: () => jumpPage(Routes.home),
      ),
      body: _buildInfoWidget(context),
    );
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
  FirstInputInfoPresenter createPresenter() => FirstInputInfoPresenter();

  Widget _buildInfoWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题
                const Text(
                  "填写个人资料",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                // 图片
                Gaps.vGap32,
                Center(
                    child: GestureDetector(
                  onTap: () => _openImg,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 33),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey),
                    child: const LoadAssetImage("logo"),
                  ),
                )),
                Gaps.vGap50,
                // 昵称
                InputTextField(
                  controller: _nameController,
                  hintText: "请输入昵称",
                  maxLength: 10,
                  isNickName: true,
                  focusNode: _nodeText,
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
                // 性别选择按钮
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            child: SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LoadAssetImage(
                                    sex.value == 0
                                        ? "login/ic_man_select"
                                        : "login/ic_man_normal",
                                    width: 30,
                                    height: 30,
                                  ),
                                  Gaps.hGap8,
                                  Text(
                                    "男生",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: sex.value == 0
                                          ? Colours.theme_end
                                          : Colours.color_999,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => sex.value = 0,
                          ),
                          Container(
                            height: sex.value == 0 ? 2 : 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  sex.value == 0 ? 2 : 0.8),
                              color: sex.value == 0
                                  ? Colours.theme_end
                                  : Colours.color_eee,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.hGap32,
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => sex.value = 1,
                            child: SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LoadAssetImage(
                                    sex.value == 1
                                        ? "login/ic_woman_select"
                                        : "login/ic_woman_normal",
                                    width: 30,
                                    height: 30,
                                  ),
                                  Gaps.hGap8,
                                  Text(
                                    "女生",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: sex.value == 1
                                          ? Colours.color_ff8772
                                          : Colours.color_999,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: sex.value == 1 ? 2 : 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  sex.value == 1 ? 2 : 0.8),
                              color: sex.value == 1
                                  ? Colours.color_ff8772
                                  : Colours.color_eee,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
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

  // 保存信息
  void _saveInfo() {
    presenter?.saveUserInfo(
        imgPath.value, _nameController.text, birthday.value, sex.value);
  }

  // 打开相册
  void _openImg() {}
}
