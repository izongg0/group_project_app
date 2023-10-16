import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/team_widget.dart';
import 'package:group_project/component/work_widget.dart';
import 'package:group_project/controller/addteam_controller.dart';
import 'package:group_project/controller/home_controller.dart';
import 'package:group_project/model/teamDTO.dart';
import 'package:group_project/page/addteam.dart';
import 'package:group_project/page/myworklist.dart';

import '../repository/user_repo.dart';
import 'teamhome.dart';

class Home extends GetView<HomeController> {
  Home({super.key});

  var controller = Get.put(HomeController());
  Widget _myWork(BuildContext context) {



    return Container(
      child: Obx(() => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('나의 할일'),
                  IconButton(
                      onPressed: () {
     

                        Get.to(MyWorkList())!.then((result) {
                          // 이곳에서 돌아왔을 때 처리할 로직
                          if (result == null) {
                            controller.onInit();
                            // Get.find<HomeController>().onInit();
                            print('ㅁㅇㄹㅁㄴ');
                          }
                        });
                      },
                      icon: Icon(Icons.more_horiz)),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              ...List.generate(
                  controller.myTask.value.length ,
                  (index) => WorkCard(
                      teamName: controller.myTask.value[index].teamName!,
                      description: controller.myTask.value[index].description!,
                      endDate:
                          controller.myTask.value[index].endDate!,workType: WorkType.MY_WORK,))
            ],
          )),
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
                                thisTeam: controller.myTeamMap.value.values
                                    .toList()[index],
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
      body: SingleChildScrollView(
        child: Padding(
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
            _myWork(context),
            SizedBox(
              height: 10,
            ),
            _myTeam(context)
          ]),
        ),
      ),
    );
  }
}
