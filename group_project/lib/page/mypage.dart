import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/profile_widget.dart';

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
            animal: controller.currentMan.value.thumbnail ?? 'assets/default_img.png',
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
                  Text('이메일'),SizedBox(height: 30,),
                  Text('학교'),SizedBox(height: 30,),
                  Text('학번')
                ],
              ),
              SizedBox(width: 40,),
               Obx(()=>Column(
                children: [
                  Text(controller.currentMan.value.email ?? 'None'),SizedBox(height: 30,),
                  Text(controller.currentMan.value.school ?? 'None'),SizedBox(height: 30,),
                  Text(controller.currentMan.value.classnum ?? 'None')
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
