import 'package:flutter/material.dart';

enum WorkType { MY_WORK, GROUP_WORK}

class WorkCard extends StatelessWidget {
  final String teamName;
  final String description;
  final String startDate;
  final String endDate;
  String? worker;
  final WorkType workType;

  WorkCard(
      {super.key,
      required String this.teamName,
      required String this.description,
      required String this.startDate,
      required String this.endDate,
      this.worker= 'x',
      required this.workType,

      });



  Widget _mywork(){
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
              SizedBox(
                height: 3,
              ),
              Text(teamName,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 3,
              ),
              Text(description),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('$startDate ~ $endDate',style: TextStyle(
                        fontSize: 12,
                      )),
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
  Widget _groupWork(){
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
              
              SizedBox(
                height: 3,
              ),
              Text('담당자 : ${worker}',style: TextStyle(fontSize: 13),),
              SizedBox(
                height: 7,
              ),
              Text(description),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('$startDate ~ $endDate',style: TextStyle(
                        fontSize: 12,
                      )),
                  SizedBox(width: 7,),
                  Text('마감 3일 전',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (workType) {
      case WorkType.MY_WORK:
        return _mywork();
      case WorkType.GROUP_WORK:
        return _groupWork();
      
    }
  }
}
