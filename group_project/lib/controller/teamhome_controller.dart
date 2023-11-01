import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/model/CommentDTO.dart';

import '../component/popup_widget.dart';
import '../model/postDTO.dart';
import '../model/taskDTO.dart';
import '../model/teamDTO.dart';
import '../model/userDTO.dart';
import '../repository/post_repo.dart';
import '../repository/task_repo.dart';
import '../repository/team_repo.dart';
import '../repository/user_repo.dart';
import 'home_controller.dart';

class TeamHomeController extends GetxController {
  var thisTeam = TeamDTO().obs;

  RxList<UserDTO> members = RxList<UserDTO>();
  RxList<String> teamMember = RxList<String>();
  TextEditingController inputDesController = TextEditingController();
  TextEditingController inputCtController = TextEditingController();
  RxList<PostDTO> teamPost = RxList<PostDTO>();
  RxList<TaskDTO> teamTask = RxList<TaskDTO>();
  RxList<CommentDTO> teamComment = RxList<CommentDTO>();
  var currentPostUid = "".obs;
  

  var currentUser = UserDTO().obs;
  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onInit() async {
    currentUser.value = await UserRepo.getCurrentUserDTOByUid();
    super.onInit();
  }

  Future<void> getTeamPost() async {
    teamPost(await PostRepo.getTeamPost(thisTeam.value.teamUid!));
  }

  Future<List<TaskDTO>> getTeamTask() async {
    teamTask(await TaskRepo.getTeamTask(thisTeam.value.teamUid!));

    return teamTask;
  }

  Future<void> getComment() async {
    teamComment(await PostRepo.getComment(currentPostUid.value));
  }

  Future<void> addComment() async {
    showDialog(
        context: Get.context!,
        builder: (context) => PopupWidget(
            content: '댓글을 작성 하시겠습니까?',
            okfunc: () async {
              var commentData = CommentDTO(
                  masterUid: auth.currentUser!.uid,
                  masterName: currentUser.value.userName,
                  postUid: currentPostUid.value,
                  userThumb: currentUser.value.thumbnail,
                  comment: inputCtController.text,
                  date: DateTime.now());

              await PostRepo.addComment(commentData);

              Navigator.pop(context);
              inputCtController.clear();
              getComment();
              // Get.to(GroupWork(),arguments: currentTeam);
            },
            nofunc: () {
              Navigator.pop(context);
            }));
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
