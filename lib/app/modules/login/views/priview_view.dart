import 'dart:io';

import 'package:camera_geo/app/data/themes.dart';
import 'package:camera_geo/app/modules/login/controllers/login_controller.dart';
import 'package:camera_geo/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class PriviewView extends GetView {
  PriviewView({Key? key}) : super(key: key);
  final loginC = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Expanded(
              child: WidgetsToImage(
                controller: loginC.widgetToImageC,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(
                      File(loginC.imagePath.value),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Tanggal : ${loginC.tanggal}",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Latitude : ${loginC.latitude.value}",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Longitude : ${loginC.longitude.value}",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Alamat : ${loginC.address.value}",
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    title: "Kembali",
                    color: redColor,
                    onPressed: () {
                      loginC.isSave.value = false;
                      Get.back();
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ButtonWidget(
                    title: "Simpan & Kirim",
                    color: primaryColor,
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Informasi",
                        barrierDismissible: false,
                        onWillPop: () async => await true,
                        titleStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        radius: 15,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        content: Column(
                          children: [
                            Text(
                              "Apakah anda yakin akan menyimpan dan mengirim data ini? \n Data yang sudah dikirim tidak dapat diubah kembali.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Divider(color: greyColor),
                            Row(
                              children: [
                                Expanded(
                                  child: ButtonWidget(
                                    title: "Batal",
                                    color: redColor,
                                    loading: loginC.isLoading.value,
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Obx(
                                    () => ButtonWidget(
                                      title: "Yakin",
                                      color: primaryColor,
                                      loading: loginC.isLoading.value,
                                      onPressed: () {
                                        loginC.saveToGalleryAndSendDB();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
