import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/userDTO.dart';

class TeamDTO {
  final String? masterUid;
  final String? teamName;
  final String? description;
  final String? notice;
  final DateTime? startDate;
  final DateTime? endDate;
List<String>? members;
  TeamDTO(
      {this.masterUid,
      this.teamName,
      this.description,
      this.notice,
      this.startDate,
      this.endDate,
      this.members});

  factory TeamDTO.fromJson(Map<String, dynamic> json) {
    return TeamDTO(
      masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
      teamName: json['teamName'] == null ? '' : json['teamName'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      notice: json['notice'] == null ? '' : json['notice'] as String,
      startDate: json['startDate'] == null
          ? DateTime.now()
          : json['startDate'].toDate(),
      endDate:
          json['endDate'] == null ? DateTime.now() : json['endDate'].toDate(),
      members:
          json['members'] == null ? [] : List<String>.from(json['members']),
    );
  }

  factory TeamDTO.DtofromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return TeamDTO(
      masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
      teamName: json['teamName'] == null ? '' : json['teamName'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      notice: json['notice'] == null ? '' : json['notice'] as String,
      startDate: json['startDate'] == null
          ? DateTime.now()
          : json['startDate'].toDate(),
      endDate:
          json['endDate'] == null ? DateTime.now() : json['endDate'].toDate(),
      members:
          json['members'] == null ? [] : List<String>.from(json['members']),
    );
  }


  // 미리 생성된 현재 로그인한 사용자의 정보가 담긴 Post객체에다가 새로 등록할 게시글의 내용을 담아주기 위해서.
  TeamDTO copyWith(
      {String? masterUid,
      String? teamName,
      String? description,
      DateTime? startDate,
      DateTime? endDate,
      String? notice,
      List<String>? members}) {
    return TeamDTO(
      masterUid: masterUid ?? this.masterUid,
      teamName: teamName ?? this.teamName,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      notice: notice ?? this.notice,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'masterUid': masterUid,
      'teamName': teamName,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'notice': notice,
      'members': members, // 팀 정보를 저장하는 리스트 필드 추가
    };
  }
}

