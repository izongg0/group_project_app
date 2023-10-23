import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/profile_widget.dart';
import 'package:group_project/component/purple_button.dart';

import '../model/postDTO.dart';

class Post extends StatefulWidget {
   Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
    var getPostData = Get.arguments as PostDTO ;

  Widget _header() {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileImage(animal: getPostData.currentUser!['thumbnail'], type: ProfileType.TYPE1),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  getPostData.title!,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(getPostData.currentUser!['userName']),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      getPostData.postDate.toString(),
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                )
              ],
            )
          ],
        ),
        Positioned(right: 8, top: 5, child: Icon(Icons.more_horiz))
      ],
    );
  }

  Widget _postArea() {
    return Container(
      height: 400,
      width: 400,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.9),
          spreadRadius: 0,
          blurRadius: 2.0,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getPostData.content!)
          ],
        ),
      ),
    );
  }

  Widget _viewMember() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(children: [
        Icon(Icons.check_circle_outline_rounded,size: 25,),SizedBox(width: 10,),Text('조회한 팀원')
      ],),
      SizedBox(height: 15,),
      ...List.generate(4, (index) => Text('홍길동'))
    ],);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Color(0xffF9F8F8),
        title: Text(
          '게시판',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 15,),
              _header(),
              SizedBox(
                height: 20,
              ),
              _postArea(),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: PurpleButton(
                  ontap: () {},
                  buttonText: '조회',
                  buttonWidth: 100,
                  buttonHeight: 40,
                ),
              ),
              _viewMember()
            ],
          ),
        ),
      ),
    );
  }
}
