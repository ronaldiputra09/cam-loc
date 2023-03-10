import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Color color;
  final loading;
  const ButtonWidget({
    super.key,
    this.onPressed,
    required this.title,
    required this.color,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: loading == false
            ? Text(
                "${title}",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
