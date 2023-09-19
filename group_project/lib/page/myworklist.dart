import 'package:flutter/material.dart';
import 'package:group_project/component/work_widget.dart';

class MyWorkList extends StatelessWidget {
  const MyWorkList({super.key});

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
      body: Column(children: [
        SizedBox(height: 10,),
        ...List.generate(3, (index) => WorkCard(teamName: '기술경영', description: '기술경영 ahpdㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ', startDate: '9/5', endDate: '9.25'))
      ]),
    );
  }
}