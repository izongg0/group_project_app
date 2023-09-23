import 'package:flutter/material.dart';

import '../page/post.dart';

class BoardItem extends StatelessWidget {
  String title;
  String nickname;
  String date;

   BoardItem({super.key,
    required this.title,
  required this.nickname,
  required this.date,
   });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (_)=>Post()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(border: Border(
            top: BorderSide(width: 1.0, color: const Color.fromARGB(255, 194, 194, 194)), // 위쪽 테두리
          ),),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(title),
            SizedBox(height: 3,),
            Row(children: [
        
              Text(nickname,style: TextStyle(fontSize: 12),),SizedBox(width: 8,),Text('∙'),SizedBox(width: 8,),
              Text(date,style: TextStyle(fontSize: 12),)
            ],)
        
          ]),
        ),
      ),
    );
  }
}