import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/component/board_item.dart';
import 'package:group_project/controller/teamhome_controller.dart';
import 'package:group_project/model/postDTO.dart';
import 'package:group_project/page/addpost.dart';
import 'package:group_project/repository/post_repo.dart';

import '../model/teamDTO.dart';
import 'post.dart';

class TeamBoard extends GetView<TeamHomeController> {
  TeamBoard({super.key});

  var getTeamData = Get.arguments as TeamDTO;
  final controller = Get.put(TeamHomeController());
  List<PostDTO> postList = [];


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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Obx(()=> Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        getTeamData.teamName!,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ...List.generate(
                         controller.teamPost.length,
                          (index) => GestureDetector(
                                onTap: () async{

                                  var image = await PostRepo.loadImageUrls(controller.teamPost[index].postUid!);
                                  Get.to(Post(), arguments: controller.teamPost[index]);
                                  controller.currentPostUid.value = controller.teamPost[index].postUid!;
                                                Get.find<TeamHomeController>().getComment();

                                  if(image.length>0){
                                  controller.imagePathList.value = image;


                                  }else{
                                    controller.imagePathList.value = [];
                                  }
                                  // Navigator.push(context,MaterialPageRoute(builder: (_)=>Post()));
                                },
                                child: BoardItem(
                                    title: controller.teamPost[index].title!,
                                    nickname: controller.teamPost[index]
                                            .currentUser?['userName'] ??
                                        '기본 닉네임',
                                    date: controller.teamPost[index].postDate!),
                              )),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 1.0,
                                color: const Color.fromARGB(
                                    255, 194, 194, 194)), // 위쪽 테두리
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: []),
                        ),
                      )
                    ])),
              ),
            ),
          ),
          Positioned(
              right: 13,
              bottom: 50,
              child: IconButton(
                onPressed: () {
                  Get.to(AddPost(), arguments: getTeamData);
                },
                icon: Icon(Icons.add_box_outlined),
                iconSize: 35,
              ))
        ],
      ),
    );
  }
}
