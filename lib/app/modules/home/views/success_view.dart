import 'package:camera_geo/app/data/themes.dart';
import 'package:camera_geo/app/modules/home/views/home_view.dart';
import 'package:camera_geo/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessView extends GetView {
  const SuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/success.json"),
                  Text(
                    "Berhasil",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Selamat anda berhasil mengirimkan data / foto beserta lokasi anda, Selanjutnya silahkan kembali ke halaman website untuk memilih jalur seleksi.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ButtonWidget(
            title: "Kembali",
            color: redColor,
            onPressed: () => Get.offAll(() => HomeView()),
          ),
        ],
      ),
    );
  }
}
