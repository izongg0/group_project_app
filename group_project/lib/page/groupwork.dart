import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/work_widget.dart';
import 'package:group_project/page/addschedule.dart';

import '../controller/teamtask_controller.dart';
import '../model/taskDTO.dart';
import '../model/teamDTO.dart';

class GroupWork extends StatefulWidget {
   GroupWork({super.key});

  @override
  State<GroupWork> createState() => _GroupWorkState();
}

class _GroupWorkState extends State<GroupWork> {
  var controller = Get.put(TeamTaskController());
  var getTeamData = Get.arguments as TeamDTO;
  List<TaskDTO> taskList = [];
void initState() {
    super.initState();

    Future.microtask(() async {

      // initstate 에서 비동기작업 불가능하기때문에 이렇게 사용함
      var teamTask = await controller.getTeamTask(getTeamData.teamUid!);
      // setState를 호출하여 화면을 다시 그리도록 합니다.
      setState(() {
        taskList = teamTask;
        print(taskList.first.toMap());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print( controller.getTeamTask(getTeamData.teamUid!));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black,
          ),
        elevation: 0,
        backgroundColor: Color(0xffF9F8F8),
        title: Text('팀 과업',style: TextStyle(color: Colors.black,fontSize: 17),),
        centerTitle: true,
      ),
      body:  Column(children: [
         Padding(
           padding: const EdgeInsets.only(right:10.0),
           child: Align(
            alignment: Alignment.topRight,
             child: IconButton(
                    onPressed: () {
           
                  Get.to(AddSchedule(),arguments: getTeamData);
                    },
                    icon: Icon(Icons.add_box_outlined),
                    iconSize: 30,
                  ),
           ),
         ),
          ...List.generate(taskList.length, (index) => WorkCard(teamName: taskList[index].teamName!, description: taskList[index].description!, endDate: taskList[index].endDate!,workType: WorkType.GROUP_WORK,))
             
      ]
      
    ));
  }
}