import 'package:get/get.dart';
import 'package:group_project/repository/task_repo.dart';

import '../model/taskDTO.dart';

class TeamTaskController extends GetxController {

  RxList<TaskDTO> teamTask = RxList<TaskDTO>();

 Future<List<TaskDTO>> getTeamTask(String teamUid) async {
    
    // List<TaskDTO> teamTask = [];
  teamTask(await TaskRepo.getTeamTask(teamUid));
    return teamTask;
  }

}