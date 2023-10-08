import 'package:flutter/material.dart';

class HomeWordWidget extends StatelessWidget {
  final String teamName;
  final String description;
  final String endDate;

  const HomeWordWidget(
      {super.key,
      required String this.teamName,
      required String this.description,
      required String this.endDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
        ], borderRadius: BorderRadius.circular(10), color: Color(0xffE6E7FB)),
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
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text('마감 3일 전',
                      style: TextStyle(
                        fontSize: 10,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
