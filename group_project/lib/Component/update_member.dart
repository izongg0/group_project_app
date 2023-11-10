import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/Component/purple_button.dart';

import '../controller/teamhome_controller.dart';
import 'add_member_widget.dart';

class UpdateMember extends StatelessWidget {
  String content;
  final Function()? okfunc;
  final Function()? nofunc;

  UpdateMember(
      {super.key,
      required this.content,
      required this.okfunc,
      required this.nofunc});
  var controller = Get.put(TeamHomeController());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            // 창 둥글게
            borderRadius: BorderRadius.circular(20),
            child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text("멤버 추가",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    SizedBox(
                      height: 30,
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
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "  이메일을 작성하고 추가를 누르세요.",
                                  hintStyle: TextStyle(fontSize: 13)),
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
                                    .updateMember(controller.inputMember.text);
                                controller.inputMember.clear();
                              },
                              child: Text(
                                '검색',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
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
                                      memberName: controller
                                          .items.value[index].userName!,
                                      delectMember: () {
                                        controller.currentMembers.remove(
                                            controller.items.value[index].uid);

                                        controller.items.remove(
                                            controller.items.value[index]);
                                      },
                                    )),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PurpleButton(
                            ontap: okfunc, buttonText: "추가", buttonWidth: 140),
                        PurpleButton(
                            ontap: nofunc, buttonText: "닫기", buttonWidth: 140)
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
