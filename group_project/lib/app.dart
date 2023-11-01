import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:group_project/page/alarm.dart';
import 'package:group_project/page/home.dart';
import 'package:group_project/page/mypage.dart';

import 'binding/initbinding.dart';
import 'controller/nav_controller.dart';

void main() {
  runApp(App());
}

class App extends GetView<BottomNavController> {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
        initialBinding: InitBining(),
        home: Obx(() => Scaffold(
              body: IndexedStack(
                  index: controller.pageIndex.value,
                  // children:  [Home(), Alarm(), Mypage()]),
                  children: [Home(), Mypage()]),
              bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: Color(0xffB2B2FF),
                  onTap: controller.changeBottomNav,
                  // // 라벨 없이 아이콘만 들어가도록
                  // showSelectedLabels: false,
                  // showUnselectedLabels: false,
                  elevation: 3,
                  type: BottomNavigationBarType
                      .fixed, // 버튼이 활성화 되었을 때 위로 안올라가게 고정
                  currentIndex: controller.pageIndex.value,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        activeIcon: Icon(Icons.home),
                        label: 'Home'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.alarm),
                    //     activeIcon: Icon(Icons.alarm),
                    //     label: 'Alarm'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        activeIcon: Icon(Icons.person),
                        label: 'Mypage')
                  ]),
            )),
      ),
    );
  }
}
