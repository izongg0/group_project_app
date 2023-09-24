import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/teamDTO.dart';

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





  // static Future<void> getYourTeams() async {
  //   try {
  //     // 'teams' 컬렉션에서 'members' 배열에 본인의 UID가 포함된 문서를 쿼리합니다.
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('teams')
  //         .where('members', arrayContains: auth.currentUser!.uid)
  //         .get();

  //     // 쿼리 결과를 반복하면서 팀 정보를 가져옵니다.
     

  //     // 본인의 팀 목록을 사용할 수 있습니다.
  //     // print(yourTeams);
  //   } catch (e) {
  //     print('Error getting teams: $e');
  //   }
  // }
}
