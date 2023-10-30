import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/controller/addtask_controller.dart';
import 'package:group_project/controller/teamhome_controller.dart';
import 'package:group_project/model/userDTO.dart';

import '../component/popup_widget.dart';
import '../component/purple_button.dart';
import '../model/teamDTO.dart';
import '../repository/team_repo.dart';

class EditNotice extends StatefulWidget {
  EditNotice({super.key});

  @override
  State<EditNotice> createState() => _EditNoticeState();
}

class _EditNoticeState extends State<EditNotice> {
  @override
  final controller = Get.put(TeamHomeController());

  var getTeamData = Get.arguments as TeamDTO;
  var teamNotice = "";



  @override
  Widget build(BuildContext context) {

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
            '공지 편집',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                '공지',
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffD9D9D9)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                   keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: controller.inputDesController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            
              SizedBox(
                height: 7,
              ),
           
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   '담당자',
              // ),
              // ...List.generate(currentTeam.length, (index) => Text(currentTeam.members![index])),
              
              Align(
                alignment: Alignment.center,
                child: PurpleButton(
                    ontap: controller.setNotice,
                    buttonText: '생성',
                    buttonWidth: 300),
              )
            ],
          ),
        ),
      ),
    );
  }
}
