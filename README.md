# flutter_pet

FlutterPet

## Getting Started

## libs

- 网络库 https://github.com/flutterchina/dio (^4.0.1)

- quick_actions 快捷入口（ios）

## other
- windows 无法编译 找不到 vs

## ChangeNotifierProvider（类似观察者，例如homePage中，viewPage + bottomNavigationBar）
- 1.注册通知
- 2.通过ChangeNotifierProvider来订阅注册通知
- 3.Consumer 来通知UI进行调整 


### MVVM架构
- 状态管理（provider）
- 业务需求添加架构
- 开启线程来解析数据，避免页面卡顿 compute
- 封装dio,
- 将flutter代码作为打包插件（android arr）给app使用