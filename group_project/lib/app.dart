import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:group_project/page/alarm.dart';
import 'package:group_project/page/home.dart';
import 'package:group_project/page/mypage.dart';

import 'binding/initbinding.dart';
import 'controller/nav_controller.dart';

void main() {
  runApp(const App());
}

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'),
      ],
      initialBinding: InitBining(),
      home: Obx(() => Scaffold(
            body: IndexedStack(
                index: controller.pageIndex.value,
                children: const [Home(), Alarm(), Mypage()]),
            bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Color(0xffB2B2FF),
                onTap: controller.changeBottomNav,
                // // 라벨 없이 아이콘만 들어가도록
                // showSelectedLabels: false,
                // showUnselectedLabels: false,
                elevation: 3,
                type:
                    BottomNavigationBarType.fixed, // 버튼이 활성화 되었을 때 위로 안올라가게 고정
                currentIndex: controller.pageIndex.value,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      activeIcon: Icon(Icons.home),
                      label: 'aaaa'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      activeIcon: Icon(Icons.home),
                      label: 'bbbb'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      activeIcon: Icon(Icons.home),
                      label: 'cccc')
                ]),
          )),
    );
  }
}
