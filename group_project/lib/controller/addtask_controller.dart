import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/controller/teamtask_controller.dart';
import 'package:group_project/model/taskDTO.dart';
import 'package:group_project/model/teamDTO.dart';
import 'package:group_project/page/groupwork.dart';
import 'package:group_project/repository/task_repo.dart';
import 'package:group_project/repository/user_repo.dart';

import '../component/popup_widget.dart';
import '../model/userDTO.dart';
import '../repository/team_repo.dart';
import 'home_controller.dart';

class AddTaskController extends GetxController {
  Rx<DateTime> endSelectedDate = DateTime.now().obs; // 이거사용
  Rx<TimeOfDay> endSelectedTime = TimeOfDay.now().obs;
  var currentTeam = TeamDTO();
  TextEditingController inputDesController = TextEditingController();

  void unfocusKeyboard() {
    print("여기까지? ${currentTeam}");
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // void onInit() async {
  //   super.onInit();

  // }

  Future<void> endSelectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: endSelectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale: const Locale('ko', 'KR'));

    if (pickedDate != null && pickedDate != endSelectedDate.value) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: endSelectedTime.value,
      );

      if (pickedTime != null) {
        endSelectedDate(DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
      }
    }
  }

  Future<void> ismake() async {
    showDialog(
        context: Get.context!,
        builder: (context) => PopupWidget(
            content: '생성 하시겠습니까?',
            okfunc: () async {
              var taskData = TaskDTO(
                masterUid: auth.currentUser?.uid,
                teamUid: currentTeam.teamUid,
                teamName: currentTeam.teamName,
                description: inputDesController.text,
                endDate: endSelectedDate.value,
              );

              await TaskRepo.addTask(taskData);
              Get.find<HomeController>().onInit();
              Get.find<TeamTaskController>().onInit();

              Navigator.pop(context);

              Get.until((route) => Get.currentRoute == '/GroupWork');
              // Get.to(GroupWork(),arguments: currentTeam);
            },
            nofunc: () {
              Navigator.pop(context);
            }));
  }
}
