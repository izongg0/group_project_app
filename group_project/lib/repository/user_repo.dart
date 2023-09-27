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

// 자기가 속해있는 팀 리스트를 가져오는 함수
  static Future<Map<String,TeamDTO>> getYourTeams() async {

     // 'teams' 컬렉션에서 'members' 배열에 본인의 UID가 포함된 문서를 쿼리합니다.
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('members', arrayContains: auth.currentUser!.uid)
          .get();
      // List<TeamDTO> teamList = [];
      Map<String,TeamDTO> teamMap ={};
      // List<String> teamUidList = [];
      // List<dynamic> teamSet = [teamList,teamUidList];
      for (var doc in querySnapshot.docs) {
        var transdata = TeamDTO.DtofromJson(
          
            doc as QueryDocumentSnapshot<Map<String, dynamic>>);
            teamMap[doc.id] = transdata;
        // teamList.add(transdata);
        // print(teamList);
        
      }
      print(teamMap);
      return teamMap;
    // try {
     


    // } catch (e) {
    //   print('Error getting teams: $e');
    
    // }
    
  }
  
}
