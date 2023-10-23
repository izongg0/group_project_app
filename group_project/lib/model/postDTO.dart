import 'package:cloud_firestore/cloud_firestore.dart';

class PostDTO {
  final String? masterUid;
  final String? teamUid;
  final String? teamName;
  final String? postUid;
  final String? title;
  final String? content;
  final DateTime? postDate;
  final List<String>? viewMember;
  final Map<String, dynamic>? currentUser; // currentUser 변수 추가

  PostDTO({
    this.masterUid,
    this.teamUid,
    this.teamName,
    this.postUid,
    this.title,
    this.content,
    this.postDate,
    this.viewMember,
    this.currentUser, // currentUser 변수 추가
  });

  factory PostDTO.fromJson(Map<String, dynamic> json) {
  return PostDTO(
    masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
    teamUid: json['teamUid'] == null ? '' : json['teamUid'] as String,
    postUid: json['postUid'] == null ? '' : json['postUid'] as String,
    title: json['title'] == null ? '' : json['title'] as String,
    teamName: json['teamName'] == null ? '' : json['teamName'] as String,
    content: json['content'] == null ? '' : json['content'] as String,
    postDate: json['postDate'] == null ? DateTime.now() : json['postDate'].toDate(),
    viewMember: json['viewMember'] == null ? [] : List<String>.from(json['viewMember']),
    currentUser: json['currentUser'], // currentUser 변수 추가
  );
}

  factory PostDTO.DtofromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return PostDTO(
      masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
      teamUid: json['teamUid'] == null ? '' : json['teamUid'] as String,
      postUid: json['postUid'] == null ? '' : json['postUid'] as String,
      title: json['title'] == null ? '' : json['title'] as String,
      teamName: json['teamName'] == null ? '' : json['teamName'] as String,
      content: json['content'] == null ? '' : json['content'] as String,
      postDate:
          json['postDate'] == null ? DateTime.now() : json['postDate'].toDate(),
      viewMember: json['viewMember'] == null
          ? []
          : List<String>.from(json['viewMember']),
              currentUser: json['currentUser'], // currentUser 변수 추가

    );
  }

  // 미리 생성된 현재 로그인한 사용자의 정보가 담긴 Post객체에다가 새로 등록할 게시글의 내용을 담아주기 위해서.
  PostDTO copyWith(
      {String? masterUid,
      String? teamUid,
      String? teamName,
      String? postUid,
      String? title,
      String? content,
      DateTime? postDate,
      List<String>? viewMember}) {
    return PostDTO(
      masterUid: masterUid ?? this.masterUid,
      teamUid: teamUid ?? this.teamUid,
      teamName: teamName ?? this.teamName,
      postUid: postUid ?? this.postUid,
      title: title ?? this.title,
      content: content ?? this.content,
      postDate: postDate ?? this.postDate,
      viewMember: viewMember ?? this.viewMember,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'masterUid': masterUid,
      'teamUid': teamUid,
      'postUid': postUid,
      'title': title,
      'teamName': teamName,
      'content': content,
      'postDate': postDate,
      'viewMember': viewMember,
      'currentUser': currentUser, // currentUser 변수 추가
    };
  }
}
