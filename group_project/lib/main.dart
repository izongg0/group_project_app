import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/login.dart';
import 'package:group_project/signup.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}
