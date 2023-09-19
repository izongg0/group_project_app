import 'package:flutter/material.dart';
import 'package:group_project/page/teamhome.dart';

class TeamCard extends StatelessWidget {
  final String teamName;
  final String description;
  final String startDate;
  final String endDate;

  const TeamCard(
      {super.key,
      required String this.teamName,
      required String this.description,
      required String this.startDate,
      required String this.endDate});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 16),
        width: 200,
        height: 260,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xffE6E7FB))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(teamName),
              SizedBox(
                height: 10,
              ),
              Container(height: 110, child: Text(description)),
              Text('$startDate ~ $endDate'),
              SizedBox(
                height: 20,
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
