import 'package:group_project/model/userDTO.dart';

class TeamDTO {
  final String? uid;
  final String? teamName;
  final String? description;
  final String? notice;
  final DateTime? startDate;
  final DateTime? endDate;
  List<String>? members; // 팀 정보를 저장하는 리스트

  TeamDTO(
      {this.uid,
      this.teamName,
      this.description,
      this.notice,
      this.startDate,
      this.endDate,
      this.members});

  factory TeamDTO.fromJson(String docId, Map<String, dynamic> json) {
    return TeamDTO(
      uid: json['uid'] == null ? '' : json['uid'] as String,
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
      {String? uid,
      String? teamName,
      String? description,
      DateTime? startDate,
      DateTime? endDate,
      String? notice,
      List<String>? members}) {
    return TeamDTO(
      uid: uid ?? this.uid,
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
      'uid': uid,
      'teamName': teamName,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'notice': notice,
      'members': members, // 팀 정보를 저장하는 리스트 필드 추가
    };
  }
}

// class TeamDTO {
//   final String? uid;
//   final String? teamName;
//   final String? description;
//   final String? notice;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   List<UserDTO>? members; // 팀 정보를 저장하는 리스트

//   TeamDTO(
//       {this.uid,
//       this.teamName,
//       this.description,
//       this.notice,
//       this.startDate,
//       this.endDate,
//       this.members});


//   factory TeamDTO.fromJson(String docId, Map<String, dynamic> json) {
//     return TeamDTO(
//       uid: json['uid'] == null ? '' : json['uid'] as String,
//       teamName: json['teamName'] == null ? '' : json['teamName'] as String,
//       description:
//           json['description'] == null ? '' : json['description'] as String,
// notice:
//           json['notice'] == null ? '' : json['notice'] as String,
//       startDate: json['startDate'] == null
//           ? DateTime.now()
//           : json['startDate'].toDate(),
//       endDate:
//           json['endDate'] == null ? DateTime.now() : json['endDate'].toDate(),
//           members: json['members'] == null ? [] : (json['members'] as List<dynamic>).map((e) => UserDTO.fromJson(e)).toList(),

//     );
//   }

//   // 미리 생성된 현재 로그인한 사용자의 정보가 담긴 Post객체에다가 새로 등록할 게시글의 내용을 담아주기 위해서.
//   TeamDTO copyWith(
//       {String? uid,
//       String? teamName,
//       String? description,
//       DateTime? startDate,
//       DateTime? endDate,
//       String? notice,
//       List<UserDTO>? members}) {
//     return TeamDTO(
//       uid: uid ?? this.uid,
//       teamName: teamName ?? this.teamName,
//       description: description ?? this.description,
//       startDate: startDate ?? this.startDate,
//       endDate: endDate ?? this.endDate,
//       notice: notice?? this.notice,
//       members: members ?? this.members,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'teamName': teamName,
//       'description': description,
//       'startDate': startDate,
//       'endDate': endDate,
//       'notice': notice,
//       'members': members, // 팀 정보를 저장하는 리스트 필드 추가
//     };
//   }
// }



  // factory TeamDTO.init(UserDTO userInfo) {
  //   // 현재 로그인한 사용자의 정보를 미리 넣어두어
  //   // 현재 게시글을 누가 작성하는지 저장하기 위함임.
  //   return TeamDTO(
  //     teamName: '',
  //     description: '',
  //   );
  // }