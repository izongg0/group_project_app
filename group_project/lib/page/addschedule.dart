import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/controller/addtask_controller.dart';
import 'package:group_project/model/userDTO.dart';

import '../component/popup_widget.dart';
import '../component/purple_button.dart';
import '../model/teamDTO.dart';

class AddSchedule extends GetView<AddTaskController> {
  AddSchedule({super.key});

  @override
  final controller = Get.put(AddTaskController());
  var getTeamData = Get.arguments as TeamDTO;
  
// https://api.flutter.dev/flutter/cupertino/CupertinoDatePicker-class.html

  @override
  Widget build(BuildContext context) {
    controller.currentTeam = getTeamData;
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
            '업무 생성',
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
                '업무',
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
                  controller: controller.inputDesController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
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
                      child: Obx(()=>Text(controller.endSelectedDate.value.toString()))),
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
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   '담당자',
              // ),
              // ...List.generate(currentTeam.length, (index) => Text(currentTeam.members![index])),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: PurpleButton(
                    ontap: controller.ismake,
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
