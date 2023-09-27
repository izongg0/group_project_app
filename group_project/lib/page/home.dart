import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/home_work_widget.dart';
import 'package:group_project/component/team_widget.dart';
import 'package:group_project/controller/addteam_controller.dart';
import 'package:group_project/controller/home_controller.dart';
import 'package:group_project/model/teamDTO.dart';
import 'package:group_project/page/addteam.dart';
import 'package:group_project/page/myworklist.dart';

import '../repository/user_repo.dart';

class Home extends GetView<HomeController> {
  Home({super.key});

  var controller = Get.put(HomeController());

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
                    Get.to(MyWorkList());
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

  Widget _myTeam(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('팀'),
            IconButton(
                onPressed: () async {
                  Get.delete<HomeController>();

                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTeam()),
                  );

                  // 다시 이전 페이지로 돌아왔을 때의 처리 (예: 결과 출력)
                  if (result == null) {
                    controller = Get.put(HomeController(),
                        // 앱이 종료되기 전까지 이 인스턴스는 살아있음.
                        permanent: false);
                    print('aaaa');
                  } else {}

                  // Get.to(AddTeam());
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
            child: Obx(
              () => Row(
                  children: List.generate(
                          controller.myTeamMap.value.values.toList().length,
                          (index) => TeamCard(
                                teamName: controller.myTeamMap.value.values
                                    .toList()[index]
                                    .teamName!,
                                description: controller.myTeamMap.value.values
                                    .toList()[index]
                                    .description!,
                                startDate: controller.myTeamMap.value.values
                                    .toList()[index]
                                    .startDate!,
                                endDate: controller.myTeamMap.value.values
                                    .toList()[index]
                                    .endDate!,
                                teamUid: controller.myTeamMap.value.keys
                                    .toList()[index],
                              ))
                      .toList()), // 데이터 모델 만들어서 객체 넘기는게 좋지만 의존성을 낮추기 위해 안함
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('홈 빌드');

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
          _myTeam(context)
        ]),
      ),
    );
  }
}
