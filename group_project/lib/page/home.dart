import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/home_work_widget.dart';
import 'package:group_project/component/team_widget.dart';
import 'package:group_project/controller/addteam_controller.dart';
import 'package:group_project/page/addteam.dart';
import 'package:group_project/page/myworklist.dart';

import '../repository/user_repo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _myWork() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('나의 할일'),
              IconButton(
                  onPressed: () {
                    // UserRepo.getYourTeams();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MyWorkList()));
                  },
                  icon: Icon(Icons.more_horiz)),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          ...List.generate(
              3,
              (index) => HomeWordWidget(
                  teamName: '기술경영 2분반 5조',
                  description: '기술경영 ahp 과제 보고서 작성',
                  startDate: '9/14',
                  endDate: '9/26'))
        ],
      ),
    );
  }

  Widget _myTeam() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('팀'),
            IconButton(
                onPressed: () {
                  Get.to(AddTeam());
                },
                icon: Icon(Icons.add_box_outlined)),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 12), // 시작부분
          child: Row(
              children: List.generate(
                  4,
                  (index) => TeamCard(
                        teamName: '기술경영 ',
                        description: '기술경영 ahp팀플 과제 입니다.',
                        startDate: '9/9',
                        endDate: '9/26',
                      )).toList()), // 데이터 모델 만들어서 객체 넘기는게 좋지만 의존성을 낮추기 위해 안함
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 80,
          ),
          Text(
            "TeamPlanner",
            style: TextStyle(
                color: Color(0xff8875FF),
                fontSize: 25,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 10,
          ),
          _myWork(),
          SizedBox(
            height: 10,
          ),
          _myTeam()
        ]),
      ),
    );
  }
}
