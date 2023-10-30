import 'package:get/get.dart';
import 'package:group_project/model/teamDTO.dart';
import 'package:group_project/page/teamhome.dart';
import 'package:group_project/repository/task_repo.dart';
import 'package:group_project/repository/team_repo.dart';
import 'package:group_project/repository/user_repo.dart';

import '../model/taskDTO.dart';
import '../model/userDTO.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // RxList<dynamic> myTeamList = RxList<dynamic>();
  RxMap<String, TeamDTO> myTeamMap = RxMap<String, TeamDTO>();

  
  RxList<TaskDTO> myTask = RxList<TaskDTO>();
  // RxList<UserDTO> members = RxList<UserDTO>();
  // RxList<String> teamMember = RxList<String>();
  var currentTeam = TeamDTO().obs;
  var teamUid = "";

  void onInit() {
    super.onInit();
    getMyTeam();
    getMytask();
  }

// teamUid로 TeamDTO 가져오기
  // Future<TeamDTO> getTeamFromUid(String teamUid) async {
  //   currentTeam(await TeamRepo.getTeamfromUid(teamUid));
  //   return currentTeam.value;
  // }

  Future<void> getMytask() async {
    myTask(await TaskRepo.getMyTask());
  }

  Future<void> getMyTeam() async {
    
    myTeamMap(await TeamRepo.getYourTeams());
  }

  // Future<List<UserDTO>> getmembers() async {
  //   members(await TeamRepo.getTeamMembers(teamMember.value));

  //   return members;
  // }
}
