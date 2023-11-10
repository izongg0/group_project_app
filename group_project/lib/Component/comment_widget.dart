import 'package:flutter/material.dart';
import 'package:group_project/component/profile_widget.dart';
import 'package:intl/intl.dart';

class CommentWidget extends StatelessWidget {
  String? thumbnail;
  String? nickname;
  DateTime? date;
  String? comment;

  CommentWidget({
    super.key,
    this.thumbnail,
    this.nickname,
    this.date,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              ProfileImage(
                animal: thumbnail??"assets/cat.png",
                type: ProfileType.TYPE1,
                nickname: "aaa",
                width: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                nickname!,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                DateFormat('yyyy-MM-dd  HH:mm:ss').format(date!),
                style: TextStyle(fontSize: 13, color: Colors.grey),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SizedBox(width: 40,),
              Text(comment!),
            ],
          ),
        ]),
      ),
    );
  }
}
