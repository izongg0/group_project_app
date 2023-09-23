import 'package:flutter/material.dart';

class Alarm extends StatelessWidget {
  const Alarm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Image.asset('assets/teamPlanner.png',width: 200,),
      ),
    );
  }
}