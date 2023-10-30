import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/work_widget.dart';

import '../controller/home_controller.dart';

class MyWorkList extends StatelessWidget {
  MyWorkList({super.key});
  
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black,
          ),
        elevation: 0,
        backgroundColor: Color(0xffF9F8F8),
        title: Text('나의 할 일',style: TextStyle(color: Colors.black,fontSize: 17),),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 10,),
               ...List.generate(
                      controller.myTask.value.length,
                      (index) => WorkCard(
                          teamName: controller.myTask.value[index].teamName!,
                          description: controller.myTask.value[index].description!,
                          worker: controller.myTask.value[index].masterName!,
                          endDate:
                              controller.myTask.value[index].endDate!,workType: WorkType.MY_WORK,))   
                                ]),
        ),
      ),
    );
  }
}