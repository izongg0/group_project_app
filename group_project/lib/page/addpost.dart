import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/Component/purple_button.dart';
import 'package:group_project/controller/addpost_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../component/popup_widget.dart';
import '../model/teamDTO.dart';

class AddPost extends StatefulWidget {
  AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final controller = Get.put(AddPostController());

  var getTeamData = Get.arguments as TeamDTO;

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> _checkPermission() async {
    var status = await Permission.photos.status;

    if (status.isGranted) {
      // 권한이 이미 허용되어 있음
      print("갤러리 권한이 허용되어 있습니다.");
    } else {
      // 권한이 허용되어 있지 않음
      if (status.isPermanentlyDenied) {
        // 사용자가 영구적으로 거부함
        openAppSettings();
      } else {
        // 권한 요청
        var result = await Permission.photos.request();
        if (result.isGranted) {
          print("갤러리 권한이 허용되었습니다.");
        }
      }
    }
  }

  final picker = ImagePicker();
  Future<void> _pickImages() async {
    // _checkPermission();
    List<XFile>? images = await ImagePicker().pickMultiImage();

    if (images != null) {
      setState(() {
        if(images.length >4){
          print("4개만 선택");
        }else{
        controller.imageList.value = images;

        }
      });
    }
  }
  

 


  Widget _addImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('이미지 추가'),SizedBox(width: 10,),Text("최대 4개",style: TextStyle(fontSize: 13,color: Colors.grey),)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                _pickImages();
              },
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 40,
                color: Colors.grey,
              ),
            ),              SizedBox(width: 15,),

            controller.imageList.isEmpty
                ? Text('이미지를 선택하세요.')
                : Obx(()=>Row(
                    children: controller.imageList.map((XFile image) {
                      return Padding(padding: EdgeInsets.only(right: 13),child: Image.file(File(image.path),width: 60,height: 60,));
                    }).toList(),
                  )),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.currentTeam = getTeamData;

    return GestureDetector(
      onTap: unfocusKeyboard,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 0,
                          blurRadius: 2.0,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: controller.inputTitleController, // 나중에 주석 풀기
                      decoration: InputDecoration(
                          hintText: '제목을 입력해주세요.',
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  // alignment: Alignment.center,
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 0,
                          blurRadius: 2.0,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textAlign: TextAlign.start,
                      textAlignVertical:
                          TextAlignVertical.top, // 텍스트를 상단에서 시작하도록 설정

                      controller:
                          controller.inputContentController, // 나중에 주석 풀기
                      decoration: InputDecoration(
                          hintText: '내용을 입력해주세요.',
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              _addImage(),
              SizedBox(
                height: 30,
              ),
              PurpleButton(
                  ontap: controller.ismake, buttonText: '작성', buttonWidth: 300)
            ]),
          ),
        ),
      ),
    );
  }
}
