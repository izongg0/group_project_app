import 'package:get/get.dart';

import '../model/teamDTO.dart';
import '../model/userDTO.dart';
import '../repository/team_repo.dart';

class TeamHomeController extends GetxController {
  TeamDTO thisTeam = TeamDTO();
  RxList<String> members = RxList<String>();
  RxList<UserDTO> membersList = RxList<UserDTO>();

  void onInit() async {
    super.onInit();
    print("여기 팀${members}");
  }

  Future<List<UserDTO>> setMembers(List<String> user) async {
    await members(user);
    membersList(await TeamRepo.getTeamMembers(members));
        print('가져와졋나?${membersList}');
    return membersList;
  }
}
