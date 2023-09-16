import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/app.dart';
import 'package:group_project/main.dart';
import 'package:group_project/signup.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F8F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGO",
              style: TextStyle(
                  color: Color(0xff8875FF),
                  fontSize: 45,
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
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => App()));
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
