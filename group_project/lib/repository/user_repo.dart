import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_project/controller/nav_controller.dart';
import 'package:group_project/model/teamDTO.dart';

import '../controller/home_controller.dart';
import '../controller/mypage_controller.dart';
import '../login.dart';
import '../model/userDTO.dart';

class UserRepo {
  static Future<List<UserDTO>> loadUserList() async {
    var document = FirebaseFirestore.instance.collection('users');
    var data = await document.get();
    return data.docs.map<UserDTO>((e) => UserDTO.fromJson(e.data())).toList();
  }

  static Future<List<UserDTO>> loadUserListByEmail(String email) async {
    var query = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email);
    var querySnapshot = await query.get();

    return querySnapshot.docs
        .map<UserDTO>((e) => UserDTO.fromJson(e.data()))
        .toList();
  }

  static Future<UserDTO> getCurrentUserDTOByUid() async {
    var query = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: auth.currentUser!.uid);
    var querySnapshot = await query.get();
    var currentUser = querySnapshot.docs
        .map<UserDTO>((e) => UserDTO.fromJson(e.data()))
        .toList();
    print(currentUser);

    return currentUser.first;
  }

  static Future<void> deleteUser(BuildContext context) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Query querytask = _firestore
        .collection('tasks')
        .where('masterUid', isEqualTo: auth.currentUser!.uid);

    querytask.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        // 각 문서를 삭제합니다.
        document.reference.delete().then((_) {
          print("과업가 성공적으로 삭제되었습니다.");
        }).catchError((error) {
          print("데이터 삭제 중 오류 발생: $error");
        });
      });
    }).catchError((error) {
      print("데이터 조회 중 오류 발생: $error");
    });
    Query queryteam = _firestore
        .collection('teams')
        .where('masterUid', isEqualTo: auth.currentUser!.uid);

    queryteam.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        // 각 문서를 삭제합니다.
        document.reference.delete().then((_) {
          print("포스트가 성공적으로 삭제되었습니다.");
        }).catchError((error) {
          print("데이터 삭제 중 오류 발생: $error");
        });
      });
    }).catchError((error) {
      print("데이터 조회 중 오류 발생: $error");
    });
    Query querypost = _firestore
        .collection('posts')
        .where('masterUid', isEqualTo: auth.currentUser!.uid);

    querypost.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        // 각 문서를 삭제합니다.
        document.reference.delete().then((_) {
          print("포스트가 성공적으로 삭제되었습니다.");
        }).catchError((error) {
          print("데이터 삭제 중 오류 발생: $error");
        });
      });
    }).catchError((error) {
      print("데이터 조회 중 오류 발생: $error");
    });
    _firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .delete()
        .then((_) {
      print("팀 삭제 완료.");
    }).catchError((error) {
      print("팀 삭제 중 오류 발생: $error");
    });

    Get.delete<BottomNavController>();
    Get.delete<HomeController>();
    Get.delete<MyPageController>();

    auth.currentUser!.delete();
    Navigator.of(context).popUntil((route) => route.isFirst);

    // Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
  }
}

FirebaseAuth auth = FirebaseAuth.instance;
