import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/popup_widget.dart';
import 'package:group_project/controller/teampost_controller.dart';
import 'package:group_project/model/postDTO.dart';
import 'package:group_project/model/userDTO.dart';
import 'package:group_project/repository/post_repo.dart';
import 'package:group_project/repository/user_repo.dart';

import '../model/teamDTO.dart';

class AddPostController extends GetxController {
    TextEditingController inputTitleController = TextEditingController();
    TextEditingController inputContentController = TextEditingController();
  var currentTeam = TeamDTO();
  var currentUser = UserDTO();

@override
  void onInit() {

    // currentUser = UserRepo.getCurrentUserDTOByUid(auth.currentUser!.uid);

    super.onInit();
  }

  Future<void> ismake() async {
    currentUser = await UserRepo.getCurrentUserDTOByUid();
    // print(currentUser.toMap());


    showDialog(
        context: Get.context!,
        builder: (context) => PopupWidget(
            content: '생성 하시겠습니까?',
            okfunc: () async {
              // var taskData = TaskDTO(
              //   masterUid: auth.currentUser?.uid,
              //   teamUid: currentTeam.teamUid,
              //   teamName: currentTeam.teamName,
              //   description: inputDesController.text,
              //   endDate: endSelectedDate.value,
              // );

              var postData = PostDTO(
                masterUid: auth.currentUser?.uid,
                teamUid: currentTeam.teamUid,
                teamName: currentTeam.teamName,
                title: inputTitleController.text,
                content: inputContentController.text,
                postDate: DateTime.now(),
                viewMember: [],
                currentUser: currentUser.toMap()
              );

              await PostRepo.addTask(postData);
              // Get.find<HomeController>().onInit();

              Navigator.pop(context);
                            Get.find<TeamPostController>().onInit();

              Get.until((route) => Get.currentRoute == '/TeamBoard');
            },
            nofunc: () {
              Navigator.pop(context);
            }));
  }


}