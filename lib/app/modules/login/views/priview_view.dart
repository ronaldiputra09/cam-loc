import 'dart:io';

import 'package:camera_geo/app/data/themes.dart';
import 'package:camera_geo/app/modules/login/controllers/login_controller.dart';
import 'package:camera_geo/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class PriviewView extends GetView {
  PriviewView({Key? key}) : super(key: key);
  final homeC = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Expanded(
              child: WidgetsToImage(
                controller: homeC.widgetToImageC,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(
                      File(homeC.imagePath.value),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Tanggal : ${homeC.tanggal}",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Latitude : ${homeC.latitude.value}",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Longitude : ${homeC.longitude.value}",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Alamat : ${homeC.address.value}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    title: "Kembali",
                    color: redColor,
                    onPressed: () {
                      homeC.isSave.value = false;
                      Get.back();
                    },
                  ),
                ),
                homeC.isSave.isFalse
                    ? Expanded(
                        child: ButtonWidget(
                          title: "Simpan & Kirim",
                          color: primaryColor,
                          onPressed: () {
                            homeC.saveToGallery();
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
