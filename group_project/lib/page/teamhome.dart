import 'package:flutter/material.dart';
import 'package:group_project/component/popup_widget.dart';
import 'package:group_project/component/profile_widget.dart';
import 'package:group_project/component/purple_button.dart';
import 'package:group_project/page/groupwork.dart';
import 'package:group_project/page/teamboard.dart';

import 'home.dart';

class TeamHome extends StatefulWidget {
  const TeamHome({super.key});

  @override
  State<TeamHome> createState() => _TeamHomeState();
}

class _TeamHomeState extends State<TeamHome> {
  Widget _notice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notice',
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          height: 18,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 0,
              blurRadius: 2.0,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ], borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Padding(padding: const EdgeInsets.all(8.0), child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('- 정기회의 : 매주 화요일 오후 10시'),

                            Text('- 화상회의 주소 : https://apps.google.com/intl/ko/intl/ko_ALL/meet/'),

            ],
          )),
        )
      ],
    );
  }

  Widget _member() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Member',
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            ...List.generate(
                3,
                (index) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: ProfileImage(
                        animal: 'cat',
                        type: ProfileType.TYPE2,
                        nickname: '홍길동',
                      ),
                    ))
          ],
        )
      ],
    );
  }

  Widget _buttonList() {
    return Column(
      children: [
        PurpleButton(
          ontap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => TeamBoard()));
          },
          buttonText: '게시판',
          buttonWidth: 400,
        ),
        SizedBox(
          height: 15,
        ),
        PurpleButton(
            ontap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => GroupWork()));
            },
            buttonText: '과업',
            buttonWidth: 400),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
                child: PurpleButton(
                    ontap: () {}, buttonText: '팀 나가기', buttonWidth: 100)),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: PurpleButton(
                    ontap: () {
                      showDialog(
                          context: context,
                          builder: (context) => PopupWidget(
                              content: '과제를 종료하시겠습니까?',
                              okfunc: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => Home()));
                              },
                              nofunc: () {
                                Navigator.pop(context);
                              }));
                    },
                    buttonText: '과제 종료',
                    buttonWidth: 100))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Color(0xffF9F8F8),
        title: Text(
          '기술경영 2분반 5조',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            _notice(),
            SizedBox(
              height: 20,
            ),
            _member(),
            SizedBox(
              height: 50,
            ),
            _buttonList()
          ],
        ),
      ),
    );
  }
}
