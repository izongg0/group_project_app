import 'package:flutter/material.dart';
import 'package:group_project/Component/purple_button.dart';

import '../component/popup_widget.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});


void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

Widget _addImage(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('이미지 추가'),
          SizedBox(height: 10,),

    Row(children: [
      Icon(Icons.add_a_photo_outlined,size: 40,color: Colors.grey,)

    ],)
  ],);
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector
    (onTap: unfocusKeyboard,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Color(0xffF9F8F8),
          title: Text(
            '글 작성',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0),
          child: Column(children: [
            SizedBox(height: 20,),
        Container(
                alignment: Alignment.center,
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 0,
                    blurRadius: 2.0,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ], borderRadius: BorderRadius.circular(5), color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    
                    // controller: textEditingController, // 나중에 주석 풀기
                    decoration: InputDecoration(
                      hintText: '제목을 입력해주세요.',
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero),
                  ),
                )),
                SizedBox(height: 20,),
                Container(
                alignment: Alignment.center,
                height: 400,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 0,
                    blurRadius: 2.0,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ], borderRadius: BorderRadius.circular(5), color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    
                    // controller: textEditingController, // 나중에 주석 풀기
                    decoration: InputDecoration(
                      hintText: '내용을 입력해주세요.',
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero),
                  ),
                )),
                SizedBox(height: 20,),
                _addImage(),
                SizedBox(height: 30,),
                PurpleButton(ontap: (){
                  showDialog(
                          context: context,
                          builder: (context) => PopupWidget(
                              content: '작성 하시겠습니까?',
                              okfunc: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              nofunc: () {
                                Navigator.pop(context);
                              }));
                  
                  }, buttonText: '작성', buttonWidth: 300)
        
          ]),
        ),
      ),
    );
  }
}