import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/login.dart';
import 'package:group_project/signup.dart';

import 'firebase_options.dart';
import 'loading.dart';

// import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // 파이어베이스 초기화
  // // https://firebase.flutter.dev/docs/overview/
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false
,
      home: Loading(),
    );
  }
}
