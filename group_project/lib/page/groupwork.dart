import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/work_widget.dart';
import 'package:group_project/controller/teamhome_controller.dart';
import 'package:group_project/page/addschedule.dart';
import 'package:group_project/repository/task_repo.dart';

import '../model/taskDTO.dart';
import '../model/teamDTO.dart';
import '../repository/user_repo.dart';

class GroupWork extends GetView<TeamHomeController> {
  GroupWork({super.key});

  @override
  var controller = Get.put(TeamHomeController());
  var getTeamData = Get.arguments as TeamDTO;
  List<TaskDTO> taskList = [];

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
            '팀 과업',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Obx(() => Column(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Get.to(AddSchedule(), arguments: getTeamData);
                      },
                      icon: Icon(Icons.add_box_outlined),
                      iconSize: 30,
                    ),
                  ),
                ),
                ...List.generate(
                    controller.teamTask.length,
                    (index) => Obx(() => WorkCard(
                          teamName: controller.teamTask[index].teamName!,
                          worker: controller.teamTask[index].masterName!,
                          description: controller.teamTask[index].description!,
                          endDate: controller.teamTask[index].endDate!,
                          workType: WorkType.GROUP_WORK,
                          ismytask: auth.currentUser!.uid ==
                              controller.teamTask[index].masterUid,
                          deletefunc: () async {
                            await controller.deleteTask(
                                controller.teamTask[index].taskUid!);
                          },
                        )))
              ])),
        ));
  }
}
