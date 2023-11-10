import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/Component/purple_button.dart';

class SelectPopup extends StatelessWidget {
  String content;
  final Function()? deletefunc;
  final Function()? updatefunc;

  SelectPopup({
    super.key,
    required this.content,
    required this.deletefunc,
    required this.updatefunc
  
  });

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
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //수정삭제 버튼 만들기
                    GestureDetector(
                      onTap: deletefunc,
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: 50,
                        child: Text('삭제',style: TextStyle(fontSize: 17),),
                        
                      ),
                    ),
                    Container(color: Colors.grey,width: Get.width,height: 0.3,),
                    Container(
                                            alignment: Alignment.center,

                      width: Get.width,
                      height: 50,
                      child: Text('수정',style: TextStyle(fontSize: 17),),

                      
                    )
                    
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
