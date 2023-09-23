import 'package:flutter/material.dart';
import 'package:group_project/component/work_widget.dart';
import 'package:group_project/page/addschedule.dart';

class GroupWork extends StatelessWidget {
  const GroupWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black,
          ),
        elevation: 0,
        backgroundColor: Color(0xffF9F8F8),
        title: Text('팀 과업',style: TextStyle(color: Colors.black,fontSize: 17),),
        centerTitle: true,
      ),
      body: Stack(
        children:[ Column(children: [
          SizedBox(height: 10,),
          ...List.generate(3, (index) => WorkCard(teamName: '기술경영', description: '기술경영 ahpdㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ', startDate: '9/5', endDate: '9.25',workType: WorkType.GROUP_WORK,))
        ]),
        Positioned(
              right: 13,
              bottom: 50,
              child: IconButton(
                onPressed: () {

                  Navigator.push(context,MaterialPageRoute(builder: (_)=>AddSchedule()));
                },
                icon: Icon(Icons.add_box_outlined),
                iconSize: 35,
              ))
        ]
      ),
    );
  }
}