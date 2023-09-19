import 'package:flutter/material.dart';

class TeamHome extends StatefulWidget {
  const TeamHome({super.key});

  @override
  State<TeamHome> createState() => _TeamHomeState();
}

class _TeamHomeState extends State<TeamHome> {
  Widget _notice(){
    return Column(children: [
      Text('Notice'),
      Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
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
          child: Text('d')
        ),
      ),
    )

    ],);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 100,),
        _notice()
    
      ],),
    );
  }
}