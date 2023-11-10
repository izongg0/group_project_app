import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/profile_widget.dart';
import 'package:group_project/component/purple_button.dart';
import 'package:group_project/component/update_member.dart';
import 'package:group_project/controller/home_controller.dart';
import 'package:group_project/controller/teamhome_controller.dart';

import 'package:group_project/page/groupwork.dart';
import 'package:group_project/page/teamboard.dart';
import 'package:group_project/repository/team_repo.dart';
import 'package:group_project/repository/user_repo.dart';

import '../component/popup_widget.dart';
import '../model/teamDTO.dart';
import '../model/userDTO.dart';
import 'editnotice.dart';

class TeamHome extends StatefulWidget {
  TeamHome({super.key});

  @override
  State<TeamHome> createState() => _TeamHomeState();
}

class _TeamHomeState extends State<TeamHome> {
  var controller = Get.put(TeamHomeController());
  List<UserDTO> memberList = [];

  var currentTeam = Get.arguments as TeamDTO;
  var teamNotice = "";

  Widget _notice(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notice',
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          height: 18,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 0,
              blurRadius: 2.0,
              offset: Offset(0, 1),
            ),
          ], borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(controller.thisTeam.value.notice ?? "f")),
                ],
              )),
        )
      ],
    );
  }

  Widget _member(BuildContext context) {
    controller.teamMember.value = currentTeam.members!;
    controller.getmembers();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Member',
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              width: 10,
            ),
            if (currentTeam.masterUid == auth.currentUser!.uid)
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => UpdateMember(
                            content: "content",
                            okfunc: ()async {
                              await TeamRepo.updateMemberData(currentTeam.teamUid!,
                                  controller.currentMembers);
                              await Get.find<TeamHomeController>().getmembers();

                              Navigator.pop(context);
                            },
                            nofunc: () {
                              Navigator.pop(context);
                            }));
                  },
                  child: Icon(Icons.add_box_outlined))
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Obx(() => Row(
              children: [
                ...List.generate(
                    controller.members.value.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ProfileImage(
                            animal: controller.members[index].thumbnail!,
                            type: ProfileType.TYPE2,
                            nickname: controller.members[index].userName,
                          ),
                        ))
              ],
            ))
      ],
    );
  }

  Widget _buttonList(BuildContext context) {
    return Column(
      children: [
        PurpleButton(
          ontap: () {
            Get.to(TeamBoard(), arguments: currentTeam);
          },
          buttonText: '게시판',
          buttonWidth: 400,
        ),
        SizedBox(
          height: 15,
        ),
        PurpleButton(
            ontap: () {
              // Get.put(TeamTaskController()).currentTeamUid.value = currentTeam.teamUid!;
              // Get.put(TeamTaskController());
              // Get.find<TeamTaskController>().currentTeamUid.value = currentTeam.teamUid!;
              Get.to(GroupWork(), arguments: currentTeam);
            },
            buttonText: '과업',
            buttonWidth: 400),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            // Expanded(
            //     child: PurpleButton(
            //         ontap: () async {}, buttonText: '팀 나가기', buttonWidth: 100)),
            // SizedBox(
            //   width: 20,
            // ),
            Expanded(
                child: PurpleButton(
                    ontap: () {
                      showDialog(
                          context: context,
                          builder: (context) => PopupWidget(
                              content:
                                  '과제를 종료하시겠습니까? \n\n※ 팀 일정, 게시글이 모두 삭제됩니다. \n※ 복구 불가능합니다.',
                              okfunc: () async {
                                await TeamRepo.deleteTeam(
                                    controller.thisTeam.value.teamUid!);
                                Get.find<HomeController>().onInit();
                                Navigator.pop(context);
                                // Navigator.pop(context);

                                Get.until((route) => Get.currentRoute == '/');
                              },
                              nofunc: () {
                                Navigator.pop(context);
                              }));
                    },
                    buttonText: '과제 종료',
                    buttonWidth: 100))
          ],
        )
      ],
    );
  }

  Widget _settings() {
    return GestureDetector(
        onTap: () {
          Get.to(EditNotice(), arguments: currentTeam);
        },
        child: Align(alignment: Alignment.centerRight, child: Text('관리')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Color(0xffF9F8F8),
        title: Text(
          controller.thisTeam.value.teamName!,
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            if (currentTeam.masterUid == auth.currentUser!.uid) _settings(),
            _notice(context),
            SizedBox(
              height: 8,
            ),
            // Align(
            //     alignment: Alignment.centerRight,
            //     child: PurpleButton(
            //       ontap: () {},
            //       buttonText: '수정',
            //       buttonWidth: 60,
            //       buttonHeight: 34,
            //     )),
            SizedBox(
              height: 15,
            ),
            _member(context),
            SizedBox(
              height: 50,
            ),
            _buttonList(context)
          ],
        ),
      ),
    );
  }
}
