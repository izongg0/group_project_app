import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  String url;

  ImageView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'x',
                  style: TextStyle(fontSize: 22,color: Colors.white),
                )),
          ),
          Container(
              height: Get.height*0.8,
              width: Get.width,
              child: PhotoView(
                imageProvider: NetworkImage(url),
              )),
        ],
      ),
    );
  }
}
