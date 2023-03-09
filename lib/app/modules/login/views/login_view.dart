import 'package:camera_geo/app/data/themes.dart';
import 'package:camera_geo/app/modules/login/views/success_view.dart';
import 'package:camera_geo/app/widgets/button_widget.dart';
import 'package:camera_geo/app/widgets/form_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final homeC = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Lottie.asset("assets/login.json")),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Silahkan masuk :",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  FormWidget(
                    hint: "Masukan username / email",
                    controller: homeC.usernameC,
                    iconPrefix: Icon(Icons.person),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => FormWidget(
                      hint: "Masukan password",
                      controller: homeC.passwordC,
                      iconPrefix: Icon(Icons.lock),
                      iconSuffix: InkWell(
                        onTap: () {
                          homeC.showPassword();
                        },
                        child: Icon(
                          homeC.isShow.isTrue
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      obsecureText: homeC.isShow.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
          homeC.bannerAd == null
              ? Container()
              : Container(
                  width: homeC.bannerAd!.size.width.toDouble(),
                  height: homeC.bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: homeC.bannerAd!),
                ),
          ButtonWidget(
            title: "Masuk",
            color: primaryColor,
            onPressed: () {
              // homeC.openCamer();
              Get.to(() => SuccessView());
            },
          ),
        ],
      ),
    );
  }
}
