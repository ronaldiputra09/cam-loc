import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Lottie.asset("assets/photo.json"),
          ),
          homeC.bannerAd == null
              ? Container()
              : Container(
                  width: homeC.bannerAd!.size.width.toDouble(),
                  height: homeC.bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: homeC.bannerAd!),
                ),
          Container(
            margin: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () => homeC.openCamer(),
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
                "Ambil Foto",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
