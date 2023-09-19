import 'package:flutter/material.dart';
import 'package:group_project/component/profile_widget.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileImage(
            animal: 'cat',
            type: ProfileType.TYPE2,
            nickname: 'izongg',
            width: 80,
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('이메일'),SizedBox(height: 30,),
                  Text('학교'),SizedBox(height: 30,),
                  Text('학번')
                ],
              ),
              SizedBox(width: 40,),
              Column(
                children: [
                  Text('izongg@naver.com'),SizedBox(height: 30,),
                  Text('부경대학교'),SizedBox(height: 30,),
                  Text('202030323')
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
