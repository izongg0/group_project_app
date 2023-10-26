import 'package:flutter/material.dart';

class Alarm extends StatelessWidget {
  const Alarm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/teamPlanner.png',width: 200,),
          SizedBox(height: 10,),
          Text('준비중 ...',style: TextStyle( color: Colors.grey,fontSize: 25,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}