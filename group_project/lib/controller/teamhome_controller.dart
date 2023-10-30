import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/teamDTO.dart';
import '../model/userDTO.dart';
import '../repository/team_repo.dart';
import 'home_controller.dart';

class TeamHomeController extends GetxController {
  var thisTeam = TeamDTO().obs;

  RxList<UserDTO> members = RxList<UserDTO>();
  RxList<String> teamMember = RxList<String>();
  TextEditingController inputDesController = TextEditingController();

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onInit() async {
  
    super.onInit();
  }

  
  // 팀 내부 데이터 수정되면 이 함수 실행하면 됨
  Future<void> getTeamFromUid(String teamUid) async {
    thisTeam(await TeamRepo.getTeamfromUid(teamUid));
      print("공지수정됨?${thisTeam.value.notice}");
    // return thisTeam.value;
  }

  Future<List<UserDTO>> getmembers() async {
    members(await TeamRepo.getTeamMembers(teamMember.value));

    return members;
  }

  Future<void> setNotice() async {
    print(thisTeam.value.teamUid ?? 'a');
    print(inputDesController.text);
    await TeamRepo.editNotice(thisTeam.value.teamUid!, inputDesController.text);
    // Get.find<TeamHomeController>().onInit();
    getTeamFromUid(thisTeam.value.teamUid!);
    Get.until((route) => Get.currentRoute == '/TeamHome');
  }

  
}
