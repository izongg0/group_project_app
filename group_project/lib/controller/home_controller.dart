import 'package:get/get.dart';
import 'package:group_project/model/teamDTO.dart';
import 'package:group_project/repository/team_repo.dart';
import 'package:group_project/repository/user_repo.dart';

import '../model/userDTO.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // RxList<dynamic> myTeamList = RxList<dynamic>();
  RxMap<String, TeamDTO> myTeamMap = RxMap<String, TeamDTO>();

  RxList<String> teamMember = RxList<String>();
  List<UserDTO> members = [];

  void onInit() {
    super.onInit();
    getMyTeam();
  }

  Future<void> getMyTeam() async {
    myTeamMap(await TeamRepo.getYourTeams());
  }

  Future<List<UserDTO>> getmembers(List<String> team) async {

    members = await TeamRepo.getTeamMembers(team);


    return members;
  }
}
