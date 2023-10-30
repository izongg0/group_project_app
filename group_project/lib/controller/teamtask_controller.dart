import 'package:get/get.dart';
import 'package:group_project/repository/task_repo.dart';

import '../model/taskDTO.dart';

class TeamTaskController extends GetxController {
  RxList<TaskDTO> teamTask = RxList<TaskDTO>();

  var currentTeamUid = "".obs;


@override
   void onInit() {
    getTeamTask();
    super.onInit();
  }

  Future<List<TaskDTO>> getTeamTask() async {
    teamTask(await TaskRepo.getTeamTask(currentTeamUid.value));


    return teamTask;
  }

}
