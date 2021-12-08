import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet/page/chat/chat_page.dart';
import 'package:flutter_pet/page/fliter/fliter_page.dart';
import 'package:flutter_pet/page/home/home_provider.dart';
import 'package:flutter_pet/page/life/life_page.dart';
import 'package:flutter_pet/page/mine/mine_page.dart';
import 'package:flutter_pet/page/plaza/plaza_page.dart';
import 'package:flutter_pet/res/colours.dart';
import 'package:flutter_pet/widget/double_tap_back_exit_app.dart';
import 'package:flutter_pet/widget/load_image.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RestorationMixin {
  static const double _imageSize = 22.0;
  final List<String> _appBarTitles = ['匹配', '宠圈', '生活', '聊天', '我的'];
  late List<Widget> _pageList;
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();
  List<BottomNavigationBarItem>? _list;

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const _tabImages = [
        [
          LoadAssetImage(
            'home/ic_planet_normal',
            width: _imageSize,
          ),
          LoadAssetImage(
            'home/ic_planet_select',
            width: _imageSize,
          )
        ],
        [
          LoadAssetImage(
            'home/ic_plaza_normal',
            width: _imageSize,
          ),
          LoadAssetImage(
            'home/ic_plaza_select',
            width: _imageSize,
          )
        ],
        [
          LoadAssetImage(
            'home/ic_explore_normal',
            width: _imageSize,
          ),
          LoadAssetImage(
            'home/ic_explore_select',
            width: _imageSize,
          )
        ],
        [
          LoadAssetImage(
            'home/ic_chat_normal',
            width: _imageSize,
          ),
          LoadAssetImage(
            'home/ic_chat_select',
            width: _imageSize,
          )
        ],
        [
          LoadAssetImage(
            'home/ic_mine_normal',
            width: _imageSize,
          ),
          LoadAssetImage(
            'home/ic_mine_select',
            width: _imageSize,
          )
        ],
      ];
      _list = List.generate(_tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _list!;
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    _pageList = [
      const FilterPage(),
      const PlazaPage(),
      const LifePage(),
      const ChatPage(),
      const MinePage(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, provider, __) {
              return BottomNavigationBar(
                selectedFontSize: 12.0,
                iconSize: 22,
                unselectedItemColor: Colours.color_999,
                selectedItemColor: Colours.color_theme,
                items: _buildBottomNavigationBarItem(),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                onTap: (index) => _pageController.jumpToPage(index),
              );
            },
          ),
          // 使用 PageView 原因 https://zhuanlan.zhihu.com/p/58582876
          body: PageView(
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            controller: _pageController,
            onPageChanged: (index) => provider.value = index,
            children: _pageList,
          ),
        ),
      ),
    );
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, 'BottomNavigationBarCurrentIndex');
  }
}
