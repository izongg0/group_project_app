import 'package:flutter/material.dart';

class WorkCard extends StatelessWidget {
  final String teamName;
  final String description;
  final String startDate;
  final String endDate;

  const WorkCard(
      {super.key,
      required String this.teamName,
      required String this.description,
      required String this.startDate,
      required String this.endDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 8),
      child: Container(
        // height: 65,
        width: 400,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            spreadRadius: 0,
            blurRadius: 2.0,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teamName,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 3,
              ),
              Text(description),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('$startDate ~ $endDate'),
                  SizedBox(width: 7,),
                  Text('마감 3일 전',
                      style: TextStyle(
                        fontSize: 10,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
