import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/comment_widget.dart';
import 'package:group_project/component/image_view.dart';
import 'package:group_project/component/profile_widget.dart';
import 'package:group_project/component/purple_button.dart';
import 'package:group_project/component/selectPopup.dart';
import 'package:intl/intl.dart';

import '../controller/teamhome_controller.dart';
import '../model/postDTO.dart';
import '../repository/user_repo.dart';

class Post extends StatefulWidget {
  Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  var getPostData = Get.arguments as PostDTO;
  var controller = Get.put(TeamHomeController());

  Widget _header() {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileImage(
                animal: getPostData.currentUser!['thumbnail'],
                type: ProfileType.TYPE1),
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
                      DateFormat('yyyy-MM-dd  HH:mm:ss')
                          .format(getPostData.postDate!),
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                )
              ],
            )
          ],
        ),
        if (getPostData.masterUid == auth.currentUser!.uid)
          Positioned(
              right: 8,
              top: 5,
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => SelectPopup(
                            content: 'dd',
                            deletefunc: () async {
                              await controller.deletePost(getPostData.postUid!);
                            },
                            updatefunc: () {}));
                  },
                  child: Icon(Icons.more_horiz)))
      ],
    );
  }

  Widget _postArea() {
    return Container(
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
            Text(getPostData.content!),
            SizedBox(
              height: 50,
            ),
            _imageList()
          ],
        ),
      ),
    );
  }

  Widget _viewMember() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text('조회한 팀원')
          ],
        ),
        SizedBox(
          height: 15,
        ),
        ...List.generate(4, (index) => Text('홍길동'))
      ],
    );
  }

  Widget _inputComment() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffD9D9D9)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)),
          width: Get.width * 0.75,
          height: 30,
          child: TextField(
            controller: controller.inputCtController,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        PurpleButton(
          ontap: controller.addComment,
          buttonText: "작성",
          buttonWidth: 40,
          buttonHeight: 30,
          fontSize: 13,
        )
      ],
    );
  }

  Widget _imageList() {
    return Column(
      children: [
        ...List.generate(
            controller.imagePathList.length,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(ImageView(url: controller.imagePathList[index]));
                    },
                    child: Image.network(
                      controller.imagePathList[index],
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ))
      ],
    );
  }



  Widget _commentList() {
    return Obx(() => Column(
          children: [
            ...List.generate(
                controller.teamComment.length,
                (index) => CommentWidget(
                      thumbnail: controller.teamComment[index].userThumb,
                      nickname: controller.teamComment[index].masterName,
                      date: controller.teamComment[index].date,
                      comment: controller.teamComment[index].comment,
                    ))
          ],
        ));
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
              SizedBox(
                height: 15,
              ),
              _header(),
              SizedBox(
                height: 20,
              ),
              _postArea(),
              SizedBox(
                height: 20,
              ),
              _commentList(),
              SizedBox(
                height: 20,
              ),
              _inputComment(),
              SizedBox(
                height: 50,
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: PurpleButton(
              //     ontap: () {},
              //     buttonText: '조회',
              //     buttonWidth: 100,
              //     buttonHeight: 40,
              //   ),
              // ),
              // _viewMember(),
              // SizedBox(height: 300,)
            ],
          ),
        ),
      ),
    );
  }
}
