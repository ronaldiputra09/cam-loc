import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Color color;
  const ButtonWidget({
    super.key,
    this.onPressed,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: Size(Get.width, 50),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
        ),
        child: Text(
          "${title}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
