import 'dart:convert';

import 'package:camera_geo/app/data/api_path.dart';
import 'package:camera_geo/app/widgets/info_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var isLoadingData = false.obs;
  var name = "".obs;
  var foto = "".obs;
  @override
  void onInit() {
    cekDataGet();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void cekDataGet() async {
    isLoadingData(true);
    Uri url = Uri.parse(ApiPath.CEK_DATA);
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${box.read('token')}",
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        name.value = data['data']['name'];
        foto.value = data['data']['pendukung_jarak'];
      } else {
        infoWidget("${data['message']}", "${response.statusCode}");
      }
    } catch (e) {
      print("Error Cek Data: ${e}");
    }
    isLoadingData(false);
  }

  void logoutPost() async {
    isLoading(true);
    Uri url = Uri.parse(ApiPath.LOGOUT);
    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${box.read('token')}",
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        box.remove("token");
        Get.offAllNamed("/login");
      } else {
        infoWidget("${data['message']}", "${response.statusCode}");
        box.remove("token");
        Get.offAllNamed("/login");
      }
    } catch (e) {
      print("Error Logout: ${e}");
      infoWidget("${e}", "00");
      box.remove("token");
      Get.offAllNamed("/login");
    }
    isLoading(false);
  }
}
