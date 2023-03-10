import 'package:camera_geo/app/data/themes.dart';
import 'package:camera_geo/app/modules/home/views/show_photo_view.dart';
import 'package:camera_geo/app/modules/login/controllers/login_controller.dart';
import 'package:camera_geo/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final homeC = Get.put(HomeController());
  final loginC = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => homeC.isLoadingData.isFalse
              ? Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/welcome.json",
                            height: Get.height * 0.3,
                          ),
                          Text(
                            "Hallo ${homeC.name.value}",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          homeC.foto.value == ""
                              ? Text(
                                  "Silahkan ambil foto untuk melanjutkan proses pendaftaran, pastikan lokasi anda aktif, jika lokasi palsu maka pendaftaran tidak dapat dilanjutkan, dan pastikan foto yang diambil memiliki background rumah anda.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 14,
                                  ),
                                )
                              : Text(
                                  "Anda telah mengirimkan foto beserta koordinat lokasi anda, silahkan kembali ke website untuk melanjutkan proses pendaftaran.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 14,
                                  ),
                                )
                        ],
                      ),
                    ),
                    homeC.foto.value == ""
                        ? ButtonWidget(
                            title: "Ambil foto",
                            color: primaryColor,
                            onPressed: () => loginC.openCamer(),
                          )
                        : ButtonWidget(
                            title: "Lihat foto",
                            color: primaryColor,
                            onPressed: () => Get.to(
                              () => ShowPhotoView(),
                              arguments: homeC.foto.value,
                            ),
                          ),
                    Divider(color: greyColor),
                    Obx(
                      () => ButtonWidget(
                        title: "Logout",
                        color: redColor,
                        loading: homeC.isLoading.value,
                        onPressed: () {
                          if (homeC.isLoading.isFalse) {
                            homeC.logoutPost();
                          }
                        },
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: primaryColor,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Sedang mencari data..",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
