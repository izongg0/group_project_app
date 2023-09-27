import 'package:flutter/material.dart';
import 'package:group_project/page/teamhome.dart';
import 'package:intl/intl.dart';

class TeamCard extends StatelessWidget {
  final String teamName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String teamUid;

  const TeamCard(
      {super.key,
      required String this.teamName,
      required String this.description,
      required DateTime this.startDate,
      required DateTime this.endDate,
      required String this.teamUid});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 16),
        width: 200,
        height: 270,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xffE6E7FB))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(teamUid),
              Text(teamName),
              SizedBox(
                height: 10,
              ),
              Container(height: 110, child: Text(description)),SizedBox(
                height: 10,
              ),
              Text('${DateFormat('yyyy-MM-dd').format(startDate)} ~ ',style: TextStyle(fontSize: 14),),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text('${DateFormat('yyyy-MM-dd').format(endDate)}',style: TextStyle(fontSize: 14),)),

              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                height: 34,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xffE6E7FB)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => TeamHome()));
                    },
                    child: Text(
                      '입장하기',
                      style: TextStyle(color: Colors.black),
                    )),
              )
            ],
          ),
        ));
  }
}
