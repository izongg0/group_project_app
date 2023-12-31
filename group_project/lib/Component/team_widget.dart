import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/controller/teamhome_controller.dart';
import 'package:group_project/page/teamhome.dart';
import 'package:intl/intl.dart';

import '../controller/home_controller.dart';
import '../model/teamDTO.dart';

class TeamCard extends StatelessWidget {
  final String teamName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final TeamDTO thisTeam;
  final String teamUid;

  const TeamCard({
    super.key,
    required this.teamName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.thisTeam,
    required this.teamUid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 16),
        width: 200,
        height: 270,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xffE6E7FB))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(teamUid),
              Text(teamName),
              SizedBox(
                height: 10,
              ),
              Container(height: 110, child: Text(description)),
              SizedBox(
                height: 10,
              ),
              Text(
                '${DateFormat('yyyy-MM-dd').format(startDate)} ~ ',
                style: TextStyle(fontSize: 14),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${DateFormat('yyyy-MM-dd').format(endDate)}',
                    style: TextStyle(fontSize: 14),
                  )),

              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                height: 34,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xffE6E7FB)),
                    onPressed: () {
                      // Get.to(TeamHome(), arguments: thisTeam);

                      // Get.delete<HomeController>();
                      print("왜?${thisTeam}");
                      Get.to(TeamHome(), arguments: thisTeam)!.then((result) {
                        // 이곳에서 돌아왔을 때 처리할 로직
                        if (result == null) {
                          Get.find<HomeController>().onInit();
                          // 반환된 데이터를 사용
                          print('ㅁㅇㄹㅁㄴ');
                        }
                      });
                      // Get.find<HomeController>().teamMember.value =
                      //     thisTeam.members!;

                      Get.put(TeamHomeController());
                      Get.find<TeamHomeController>().teamMember.value =
                          thisTeam.members!;
                      Get.find<TeamHomeController>().thisTeam.value = thisTeam;
                      Get.find<TeamHomeController>().getTeamPost();
                      Get.find<TeamHomeController>().getTeamTask();
                    },
                    child: Text(
                      '입장하기',
                      style: TextStyle(color: Colors.black),
                    )),
              )
            ],
          ),
        ));
  }
}
