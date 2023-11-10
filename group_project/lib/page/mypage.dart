import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/popup_widget.dart';
import 'package:group_project/component/profile_widget.dart';
import 'package:group_project/component/purple_button.dart';
import 'package:group_project/login.dart';

import '../controller/mypage_controller.dart';
import '../model/userDTO.dart';
import '../repository/user_repo.dart';

class Mypage extends GetView<MyPageController> {
  Mypage({super.key});

  final controller = Get.put(MyPageController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileImage(
            animal: controller.currentMan.value.thumbnail ??
                'assets/default_img.png',
            type: ProfileType.TYPE2,
            nickname: controller.currentMan.value.userName ?? 'None',
            width: 80,
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('이메일'),
                  SizedBox(
                    height: 30,
                  ),
                  Text('학교'),
                  SizedBox(
                    height: 30,
                  ),
                  Text('학번')
                ],
              ),
              SizedBox(
                width: 40,
              ),
              Obx(() => Column(
                    children: [
                      Text(controller.currentMan.value.email ?? 'None'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(controller.currentMan.value.school ?? 'None'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(controller.currentMan.value.classnum ?? 'None'),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: 180,
          ),
          PurpleButton(
              ontap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Login()));
              },
              buttonText: "로그아웃",
              buttonWidth: 300),SizedBox(
            height: 20,
          ),
          PurpleButton(
              ontap: () async {
                showDialog(
                    context: context,
                    builder: (context) => PopupWidget(
                        content:
                            '계정삭제\n\n- 본인이 생성한 팀\n- 그 팀에 포함된 모든 게시글 및 과업\n- 본인이 작성한 게시글\n- 본인의 과업\n\n모두 삭제되며 복구 불가능합니다.\n\n정말 계정을 삭제하시겠습니까?',
                        okfunc: () async {
                          await UserRepo.deleteUser(context);
                        },
                        nofunc: () {
                          Navigator.pop(context);
                        }));
              },
              buttonText: "계정 삭제",
              buttonWidth: 300)
        ],
      ),
    );
  }
}
