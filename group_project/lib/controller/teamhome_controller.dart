import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/postDTO.dart';
import '../model/taskDTO.dart';
import '../model/teamDTO.dart';
import '../model/userDTO.dart';
import '../repository/post_repo.dart';
import '../repository/task_repo.dart';
import '../repository/team_repo.dart';
import 'home_controller.dart';

class TeamHomeController extends GetxController {
  var thisTeam = TeamDTO().obs;

  RxList<UserDTO> members = RxList<UserDTO>();
  RxList<String> teamMember = RxList<String>();
  TextEditingController inputDesController = TextEditingController();

  RxList<PostDTO> teamPost = RxList<PostDTO>();
  RxList<TaskDTO> teamTask = RxList<TaskDTO>();

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onInit() async {
    super.onInit();
  }

  Future<void> getTeamPost() async {
    teamPost(await PostRepo.getTeamPost(thisTeam.value.teamUid!));
  }
  Future<List<TaskDTO>> getTeamTask() async {
    teamTask(await TaskRepo.getTeamTask(thisTeam.value.teamUid!));


    return teamTask;
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
