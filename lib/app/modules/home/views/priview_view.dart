import 'dart:io';

import 'package:camera_geo/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class PriviewView extends GetView {
  PriviewView({Key? key}) : super(key: key);
  final homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Expanded(
              child: WidgetsToImage(
                controller: homeC.widgetToImageC,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(
                      File(homeC.imagePath.value),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: Get.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Tanggal : ${homeC.tanggal}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Latitude : ${homeC.latitude.value}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Longitude : ${homeC.longitude.value}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Alamat : ${homeC.address.value}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      left: 20,
                      top: 20,
                      right: 10,
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        homeC.isSave.value = false;
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(Get.width, 50),
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 13,
                        ),
                      ),
                      child: Text(
                        "Kembali",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                homeC.isSave.isFalse
                    ? Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            right: 20,
                            top: 20,
                            left: 10,
                          ),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              homeC.saveToGallery();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: Size(Get.width, 50),
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 13,
                              ),
                            ),
                            child: Text("Simpan ke galeri",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      )
                    : SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
