import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/login.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F8F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              height: 20,
            ),
            Container(
              width: 300,
              child: Text(
                '이름',
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
                '학교',
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
                '학번',
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
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {},
                child: Text('가입'),
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
                      context, MaterialPageRoute(builder: (_) => Login()));
                },
                child: Text('뒤로가기'),
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
