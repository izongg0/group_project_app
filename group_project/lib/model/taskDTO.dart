import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDTO {
  final String? masterUid;
  final String? teamUid;
  final String? description;
  final DateTime? endDate;
  List<String>? members;



  TaskDTO(
      {this.masterUid,
      this.teamUid,
      this.description,
      this.endDate,
      this.members
      });

  factory TaskDTO.fromJson(Map<String, dynamic> json) {
    return TaskDTO(
      masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
      teamUid: json['teamUid'] == null ? '' : json['teamUid'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      endDate:
          json['endDate'] == null ? DateTime.now() : json['endDate'].toDate(),
      members:
          json['members'] == null ? [] : List<String>.from(json['members']),
    );
  }

  factory TaskDTO.DtofromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return TaskDTO(
      masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
      teamUid: json['teamUid'] == null ? '' : json['teamUid'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      endDate:
          json['endDate'] == null ? DateTime.now() : json['endDate'].toDate(),
      members:
          json['members'] == null ? [] : List<String>.from(json['members']),
    );
  }


  // 미리 생성된 현재 로그인한 사용자의 정보가 담긴 Post객체에다가 새로 등록할 게시글의 내용을 담아주기 위해서.
  TaskDTO copyWith(
      {String? masterUid,
      String? teamUid,
      String? description,
      DateTime? endDate,
      List<String>? members
      }) {
    return TaskDTO(
      masterUid: masterUid ?? this.masterUid,
      teamUid: teamUid ?? this.teamUid,
      description: description ?? this.description,
      endDate: endDate ?? this.endDate,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'masterUid': masterUid,
      'teamUid': teamUid,
      'description': description,
      'endDate': endDate,
      'members': members, 
    };
  }
}

