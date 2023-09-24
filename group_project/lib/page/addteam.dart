import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/add_member_widget.dart';
import 'package:group_project/component/purple_button.dart';
import 'package:group_project/controller/addteam_controller.dart';
import 'package:group_project/model/teamDTO.dart';
import 'package:group_project/page/home.dart';
import 'package:group_project/repository/team_repo.dart';
import 'package:group_project/repository/user_repo.dart';

import '../component/popup_widget.dart';

class AddTeam extends GetView<AddTeamController> {
  AddTeam({super.key});

  // DateTime _selectedDate = DateTime.now(); // 이거사용
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTeamController());

    return GestureDetector(
      onTap: controller.unfocusKeyboard,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Color(0xffF9F8F8),
          title: Text(
            '팀 생성',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  '팀명',
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffD9D9D9)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  height: 30,
                  width: 300,
                  child: TextField(
                    controller: controller.inputTeamNameController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '과제 설명',
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffD9D9D9)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  height: 150,
                  width: 300,
                  child: TextField(
                    controller: controller.inputDesController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '시작일',
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffD9D9D9)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        height: 30,
                        width: 230,
                        child: Obx(() =>
                            Text(controller.selectedDate.value.toString()))),
                    SizedBox(
                      // width: 250,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffE6E7FB)),
                          onPressed: () {
                            controller.StartSelectDateTime(context);
                          },
                          child: Text(
                            '날짜 선택',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '마감일',
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffD9D9D9)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        height: 30,
                        width: 230,
                        child: Obx(() =>
                            Text(controller.endSelectedDate.value.toString()))),
                    SizedBox(
                      // width: 250,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffE6E7FB)),
                          onPressed: () {
                            controller.endSelectDateTime(context);
                          },
                          child: Text(
                            '날짜 선택',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '팀원',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffD9D9D9)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        height: 30,
                        width: 230,
                        child: TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: controller.inputMember,
                        )),
                    SizedBox(
                      // width: 250,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffE6E7FB)),
                          onPressed: () async {
                            var aaa = await controller
                                .searchMember(controller.inputMember.text);
                            controller.inputMember.clear();
                          },
                          child: Text(
                            '추가',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // width: 200,
                  child: Obx(() => Wrap(
                        children: List.generate(
                            controller.items.value.length,
                            (index) => MemberWidget(
                                  memberName:
                                      controller.items.value[index].userName!,
                                  delectMember: () {
                                    controller.uidList.remove(
                                        controller.items.value[index].uid);
        
                                    controller.items
                                        .remove(controller.items.value[index]);
                                  },
                                )),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: PurpleButton(
                    ontap: () async {
                      await controller.ismake();
                    },
                    buttonText: '생성',
                    buttonWidth: Get.width*0.75,
                    buttonHeight: 35,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
