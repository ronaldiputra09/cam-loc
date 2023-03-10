import 'package:camera_geo/app/data/themes.dart';
import 'package:camera_geo/app/widgets/button_widget.dart';
import 'package:camera_geo/app/widgets/form_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final loginC = Get.put(LoginController());
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
                    hint: "Masukan NIK",
                    controller: loginC.usernameC,
                    iconPrefix: Icon(Icons.person),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => FormWidget(
                      hint: "Masukan password",
                      controller: loginC.passwordC,
                      iconPrefix: Icon(Icons.lock),
                      iconSuffix: InkWell(
                        onTap: () {
                          loginC.showPassword();
                        },
                        child: Icon(
                          loginC.isShow.isTrue
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      obsecureText: loginC.isShow.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Padding(
              padding: EdgeInsets.all(20),
              child: ButtonWidget(
                title: "Masuk",
                color: primaryColor,
                loading: loginC.isLoading.value,
                onPressed: () {
                  if (loginC.isLoading.isFalse) {
                    loginC.loginPost();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
