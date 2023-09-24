import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/app.dart';
import 'package:group_project/main.dart';
import 'package:group_project/signup.dart';

import 'model/userDTO.dart';

// 이메일 
// izongg@naver.com 
// whdgns4608@gmail.com
// whdgnsqwe@naver.com

// 비밀번호 : aaaaaa!


class Login extends StatefulWidget {
   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
    final _inputEmailController = TextEditingController();

  final _inputPwdController = TextEditingController();

void login() async {
   try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _inputEmailController.text,
                          password: _inputPwdController.text) //아이디와 비밀번호로 로그인 시도
                      .then((value) {
                    print(value);
                    value.user!.emailVerified == true //이메일 인증 여부
                        ? Navigator.push(context,
                            MaterialPageRoute(builder: (_) => App()))
                        : print('이메일 확인 안댐');
                    return value;
                  });
                } on FirebaseAuthException catch (e) {
                  //로그인 예외처리
                  if (e.code == 'user-not-found') {
                    print('등록되지 않은 이메일입니다');
                  } else if (e.code == 'wrong-password') {
                    print('비밀번호가 틀렸습니다');
                  } else {
                    print(e.code);
                  }
                }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F8F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TeamPlanner",
              style: TextStyle(
                  color: Color(0xff8875FF),
                  fontSize: 35,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 300,
              child: Text(
                '이메일',
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD9D9D9)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              height: 30,
              width: 300,
              child: TextField(
                controller: _inputEmailController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: Text(
                '비밀번호',
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD9D9D9)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              height: 30,
              width: 300,
              child: TextField(
                controller: _inputPwdController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
                onPressed: () {
                 login();
                },
                child: Text('로그인'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(280, 40),
                    shape: RoundedRectangleBorder(
                        //모서리를 둥글게
                        borderRadius: BorderRadius.circular(5)),
                    primary: Color(0xffE6E7FB),
                    onPrimary: Colors.black, //글자색

                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontSize: 15))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Signup()));
                },
                child: Text('회원가입'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(280, 40),
                    shape: RoundedRectangleBorder(
                        //모서리를 둥글게
                        borderRadius: BorderRadius.circular(5)),
                    primary: Color(0xffE6E7FB),
                    onPrimary: Colors.black, //글자색

                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontSize: 15)))
          ],
        ),
      ),
    );
  }
}
