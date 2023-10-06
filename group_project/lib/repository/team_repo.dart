import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/userDTO.dart';

import '../model/teamDTO.dart';

class TeamRepo {
  static Future<void> addTeam(TeamDTO teamData) async {
    await FirebaseFirestore.instance
        .collection('teams')
        .doc()
        .set(teamData.toMap());
  }

  // 자기가 속해있는 팀 리스트를 가져오는 함수
  static Future<Map<String, TeamDTO>> getYourTeams() async {
    // 'teams' 컬렉션에서 'members' 배열에 본인의 UID가 포함된 문서를 쿼리합니다.
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .where('members', arrayContains: auth.currentUser!.uid)
        .get();
    // List<TeamDTO> teamList = [];
    Map<String, TeamDTO> teamMap = {};
    // List<String> teamUidList = [];
    // List<dynamic> teamSet = [teamList,teamUidList];
    for (var doc in querySnapshot.docs) {
      var transdata = TeamDTO.DtofromJson(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>);
      teamMap[doc.id] = transdata;
      // teamList.add(transdata);
      // print(teamList);
    }
    // print(teamMap);
    return teamMap;
  }
static Future<List<UserDTO>> getTeamMembers(List<String> memberList) async {
    List<UserDTO> userList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereIn: memberList)
        .get();

    for (var doc in querySnapshot.docs) {
      var transdata = UserDTO.DtofromJson(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>);
          userList.add(transdata);
    }
      // print(userList);

    return userList;
  }
  
}
