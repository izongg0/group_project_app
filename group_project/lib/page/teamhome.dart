import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/popup_widget.dart';
import 'package:group_project/component/profile_widget.dart';
import 'package:group_project/component/purple_button.dart';
import 'package:group_project/controller/home_controller.dart';
import 'package:group_project/controller/teamhome_controller.dart';
import 'package:group_project/page/addschedule.dart';
import 'package:group_project/page/groupwork.dart';
import 'package:group_project/page/teamboard.dart';
import 'package:group_project/repository/team_repo.dart';
import 'package:group_project/repository/user_repo.dart';

import '../model/teamDTO.dart';
import '../model/userDTO.dart';
import 'home.dart';

class TeamHome extends StatefulWidget {
  TeamHome({super.key});

  @override
  State<TeamHome> createState() => _TeamHomeState();
}

class _TeamHomeState extends State<TeamHome> {
  var controller = Get.put(HomeController());
  List<UserDTO> memberList = [];
  var currentTeam = Get.arguments as TeamDTO;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      // initstate 에서 비동기작업 불가능하기때문에 이렇게 사용함
      var thismemberList = await controller.getmembers(controller.teamMember);
      // setState를 호출하여 화면을 다시 그리도록 합니다.
      setState(() {
        memberList = thismemberList;
      });
    });
  }

  Widget _notice(BuildContext context) {
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
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('여기 팀 uid -> ${controller.myTeamMap.value.values.toList()[0].members}'),
                  Text(
                      '- 화상회의 주소 : https://apps.google.com/intl/ko/intl/ko_ALL/meet/'),
                ],
              )),
        )
      ],
    );
  }

  Widget _member(BuildContext context) {
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
                memberList.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: ProfileImage(
                        animal: memberList[index].thumbnail!,
                        type: ProfileType.TYPE2,
                        nickname: memberList[index].userName,
                      ),
                    ))
          ],
        )
      ],
    );
  }

  Widget _buttonList(BuildContext context) {
    return Column(
      children: [
        PurpleButton(
          ontap: () {

                          Get.to(TeamBoard(),arguments: currentTeam);

  
          },
          buttonText: '게시판',
          buttonWidth: 400,
        ),
        SizedBox(
          height: 15,
        ),
        PurpleButton(
            ontap: () {
              Get.to(GroupWork(),arguments: currentTeam);
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
                    ontap: () async {}, buttonText: '팀 나가기', buttonWidth: 100)),
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

  Widget _settings() {
    return Align(alignment: Alignment.centerRight, child: Text('관리'));
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
            if (currentTeam.masterUid == auth.currentUser!.uid) _settings(),
            _notice(context),
            SizedBox(
              height: 8,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: PurpleButton(
                  ontap: () {},
                  buttonText: '수정',
                  buttonWidth: 60,
                  buttonHeight: 34,
                )),
            SizedBox(
              height: 15,
            ),
            _member(context),
            SizedBox(
              height: 50,
            ),
            _buttonList(context)
          ],
        ),
      ),
    );
  }
}
