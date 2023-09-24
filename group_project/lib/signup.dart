import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/Component/purple_button.dart';
import 'package:group_project/component/popup_widget.dart';
import 'package:group_project/component/profile_select.dart';
import 'package:group_project/login.dart';
import 'package:group_project/model/userDTO.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _inputEmailController = TextEditingController();

  final _inputPwController = TextEditingController();

  final _inputNameController = TextEditingController();

  final _inputSchoolController = TextEditingController();

  final _inputMajorController = TextEditingController();

  final _inputClassnumController = TextEditingController();

  String imgNum = 'assets/default_img.png';
  


// Firestore에 사용자 정보 추가 함수
  void addUserDataToFirestore(User user) async {
    var signupUser = UserDTO(
        uid: user.uid,
        email: _inputEmailController.text,
        userName: _inputNameController.text,
        thumbnail: imgNum,
        school: _inputSchoolController.text,
        major: _inputMajorController.text,
        classnum: _inputClassnumController.text,
        emailVerified: true); // 이메일 인증이 완료된 상태로 설정

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(signupUser.toMap());
  }

// register() 함수 호출
  void register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _inputEmailController.text,
              password: _inputPwController.text)
          .then((value) {
        if (value.user!.email == null) {
        } else {

          addUserDataToFirestore(value.user!);
          Navigator.pop(context);
        }
        return value;
      });
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('the password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('11111');
      }
    } catch (e) {
      print('끝');
    }
  }

  Future<void> _selectProfileImg(BuildContext context) async {
    String? img = await showDialog<String>(
        context: context,
        builder: (context) {
          return ProfileSelect();
        });

    setState(() {
      imgNum = img!;
    });
  }

  Widget _selectProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            '프로필 사진',
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Image.asset(
              imgNum,
              width: 40,
            ),
            GestureDetector(
                onTap: () {
                  _selectProfileImg(context);
                },
                child: Text('선택'))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F8F8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이메일',
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
              child: TextField(
                controller: _inputEmailController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '비밀번호',
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
              child: TextField(
                controller: _inputPwController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '이름',
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
              child: TextField(
                controller: _inputNameController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '학교',
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
              child: TextField(
                controller: _inputSchoolController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '전공',
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
              child: TextField(
                controller: _inputMajorController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '학번',
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
              child: TextField(
                controller: _inputClassnumController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _selectProfile(),
            SizedBox(height: 50),
            Align(
                alignment: Alignment.center,
                child: PurpleButton(
                    ontap: () {
                      register();
                    },
                    buttonText: '가입',
                    buttonWidth: 300)),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.center,
                child: PurpleButton(
                    ontap: () {
                      Navigator.pop(context);
                    },
                    buttonText: '뒤로가기',
                    buttonWidth: 300)),
          ],
        ),
      ),
    );
  }
}
