import 'package:flutter/material.dart';

class PurpleButton extends StatelessWidget {
  final Function()? ontap;
  final String buttonText;
  final double buttonWidth;
  double? buttonHeight;
  PurpleButton(
      {super.key,
      required this.ontap,
      required this.buttonText,
      required this.buttonWidth,
      this.buttonHeight = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 65,
        width: buttonWidth,
        decoration: BoxDecoration(
            color: Color(0xffE6E7FB),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                spreadRadius: 0,
                blurRadius: 2.0,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10)
            ),
        child: TextButton(
          onPressed: ontap,
          child: Text(buttonText,style: TextStyle(color: Colors.black),),
        ));
  }
}
