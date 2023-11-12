import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  RxList<String> imagePathList = RxList<String>();

  // 멤버 추가
  TextEditingController inputMember = TextEditingController();
  RxList<UserDTO> items = RxList<UserDTO>();
  RxList<String> currentMembers = RxList<String>();

  var currentPostUid = "".obs;

  var currentUser = UserDTO().obs;
  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onInit() async {
    currentUser.value = await UserRepo.getCurrentUserDTOByUid();
    super.onInit();
  }

  Future<void> updateMember(String email) async {
    var resultSearch = await UserRepo.loadUserListByEmail(email);

    if (resultSearch.isNotEmpty) {
      if (currentMembers.contains(resultSearch.first.uid)) {
        Fluttertoast.showToast(
          msg: "이미 추가한 팀원입니다.",
          toastLength: Toast
              .LENGTH_SHORT, // Toast 메시지 표시 시간 설정 (Toast.LENGTH_SHORT 또는 Toast.LENGTH_LONG)
          gravity:
              ToastGravity.BOTTOM, // Toast 메시지의 위치 설정 (TOP, CENTER, BOTTOM)
          timeInSecForIosWeb: 1, // iOS 및 웹 플랫폼에서 Toast 메시지를 표시하는 시간 설정
          backgroundColor: Colors.black, // 배경색 설정
          textColor: Colors.white, // 텍스트 색상 설정
          fontSize: 16.0, // 폰트 크기 설정
        );
      } else {
        currentMembers.add(resultSearch.first.uid!);
        items.add(resultSearch.first);
      }
    } else {
      Fluttertoast.showToast(
        msg: "존재하지 않는 이메일입니다.",
        toastLength: Toast
            .LENGTH_SHORT, // Toast 메시지 표시 시간 설정 (Toast.LENGTH_SHORT 또는 Toast.LENGTH_LONG)
        gravity: ToastGravity.BOTTOM, // Toast 메시지의 위치 설정 (TOP, CENTER, BOTTOM)
        timeInSecForIosWeb: 1, // iOS 및 웹 플랫폼에서 Toast 메시지를 표시하는 시간 설정
        backgroundColor: Colors.black, // 배경색 설정
        textColor: Colors.white, // 텍스트 색상 설정
        fontSize: 16.0, // 폰트 크기 설정
      );
    }
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

Future<void> deleteComment(String commentUid) async {
    showDialog(
        context: Get.context!,
        builder: (context) => PopupWidget(
            content: '삭제 하시겠습니까?',
            okfunc: () async {
              await PostRepo.deleteComment(commentUid);
              getComment();

              Navigator.pop(context);

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
    currentMembers.value = teamMember.value;
    items.value = members.value;
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

  Future<void> deletePost(String postUid) async {
    showDialog(
        context: Get.context!,
        builder: (context) => PopupWidget(
            content: '삭제 하시겠습니까?',
            okfunc: () async {
              await PostRepo.deletePost(postUid);
              Get.find<HomeController>().onInit();

              Navigator.pop(context);
              Get.find<TeamHomeController>().getTeamPost();
              Navigator.pop(context);

              Get.until((route) => Get.currentRoute == '/TeamBoard');
            },
            nofunc: () {
              Navigator.pop(context);
            }));
  }

  Future<void> deleteTask(String taskUid) async {
    showDialog(
        context: Get.context!,
        builder: (context) => PopupWidget(
            content: '삭제 하시겠습니까?',
            okfunc: () async {
              await TaskRepo.deleteTask(taskUid);
              Get.find<HomeController>().onInit();

              await Get.find<TeamHomeController>().getTeamTask();
              Navigator.pop(context);
            },
            nofunc: () {
              Navigator.pop(context);
            }));
  }
}
