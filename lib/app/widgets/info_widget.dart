import 'package:camera_geo/app/data/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

infoWidget(message, code) {
  Get.snackbar(
    "Informasi",
    "${message} [${code}]",
    backgroundColor: redColor,
    colorText: whiteColor,
    icon: Icon(Icons.info, color: whiteColor),
    shouldIconPulse: false,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    margin: EdgeInsets.all(20),
    duration: Duration(seconds: 3),
  );
}
