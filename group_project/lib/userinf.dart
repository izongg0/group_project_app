import 'package:flutter/material.dart';

import 'component/profile_select.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {

    String imgNum = 'assets/default_img.png';
final _inputNameController = TextEditingController();

  final _inputSchoolController = TextEditingController();

  final _inputMajorController = TextEditingController();

  final _inputClassnumController = TextEditingController();
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
    return Column(children: [
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
    ],);
  }
}