import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/work_widget.dart';
import 'package:group_project/page/addschedule.dart';

import '../controller/teamtask_controller.dart';
import '../model/taskDTO.dart';
import '../model/teamDTO.dart';

class GroupWork extends GetView<TeamTaskController> {
  GroupWork({super.key});

  @override

  var controller = Get.put(TeamTaskController());
  var getTeamData = Get.arguments as TeamDTO;
  List<TaskDTO> taskList = [];


  @override
  Widget build(BuildContext context) {
    controller.currentTeamUid.value = getTeamData.teamUid!;
    controller.getTeamTask();
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
          child: Obx(()=> Column(children: [
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
                controller.teamTask.value.length,
                (index) => WorkCard(
                      teamName: controller.teamTask.value[index].teamName!,
                      description: controller.teamTask.value[index].description!,
                      endDate: controller.teamTask.value[index].endDate!,
                      workType: WorkType.GROUP_WORK,
                    ))
          ])),
        ));
  }
}
