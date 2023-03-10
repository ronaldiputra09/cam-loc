import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera_geo/app/data/api_path.dart';
import 'package:camera_geo/app/modules/login/views/priview_view.dart';
import 'package:camera_geo/app/modules/login/views/success_view.dart';
import 'package:camera_geo/app/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final box = GetStorage();
  final imagePicker = ImagePicker();
  var imagePath = "".obs;
  var tanggal = DateTime.now();
  var latitude = "".obs;
  var longitude = "".obs;
  var address = "".obs;
  var isSave = false.obs;
  var isShow = true.obs;
  var usernameC = TextEditingController();
  var passwordC = TextEditingController();
  var isLoading = false.obs;
  StreamSubscription<Position>? streamSubscription;
  WidgetsToImageController widgetToImageC = WidgetsToImageController();
  Uint8List? bytes;

  @override
  void onInit() async {
    getLocation();
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

  @override
  void dispose() {
    imagePath.value = '';
    super.dispose();
  }

  void loginPost() async {
    isLoading.value = true;
    Uri url = Uri.parse(ApiPath.LOGIN);
    try {
      final response = await http.post(
        url,
        body: {
          "username": usernameC.text,
          "password": passwordC.text,
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (box.read("token") != null) {
          box.remove("token");
          box.write("token", data['data']['token']);
        } else {
          box.write("token", data['data']['token']);
        }
        Get.offAllNamed("/home");
      } else {
        infoWidget("${data['message']}", "${response.statusCode}");
      }
    } catch (e) {
      print("Error Login: ${e}");
    }
    isLoading.value = false;
  }

  void addKoordinatPost(String image) async {
    Uri url = Uri.parse(ApiPath.ADD_KOORDINAT);
    try {
      final request = await http.MultipartRequest('POST', url);
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer  ${box.read('token')}",
      });
      request.fields.addAll(
        {
          "lat": latitude.value,
          "long": longitude.value,
        },
      );
      if (image != "") {
        request.files.add(
          await http.MultipartFile.fromPath(
            'foto',
            image,
            filename: image.split('/').last,
          ),
        );
      }
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        var data = jsonDecode(value);
        print(data);
        if (response.statusCode != 200) {
          infoWidget("${data['message']}", "${response.statusCode}");
        } else {
          Get.offAll(() => SuccessView());
        }
      });
    } catch (e) {
      print("Error Add Koordinat: ${e}");
    }
    isLoading(false);
  }

  // show password
  void showPassword() {
    isShow.value = !isShow.value;
  }

  void saveToGalleryAndSendDB() async {
    isLoading(true);
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    final bytes = await widgetToImageC.capture();
    var exportToJpg =
        File('${dir}/image_${DateTime.now()}.jpg').writeAsBytes(bytes!);
    exportToJpg.then(
      (value) {
        GallerySaver.saveImage(value.path);
        addKoordinatPost(value.path);
        // .then(
        //   (value1) {
        //     print("BERHASIL DISIMPAN");
        //     // Get.defaultDialog(
        //     //   title: "Berhasil",
        //     //   middleText: "Gambar berhasil disimpan ke gallery",
        //     //   confirmTextColor: Colors.white,
        //     //   textConfirm: "Buka",
        //     //   onConfirm: () {
        //     //     Get.back();
        //     //     isSave.value = true;
        //     //     OpenFilex.open(value.path);
        //     //   },
        //     // );
        //   },
        // );
      },
    );
  }

  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return dialogError('Aktifkan lokasi anda sekarang,\n Lalu tekan OK!');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return dialogError('Aplikasi memerlukan izin lokasi');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return dialogError('Aplikasi memerlukan izin lokasi');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    streamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
      ),
    ).listen((Position position) {
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
      if (position.isMocked == true) {
        // dialogError('Lokasi palsu tidak diizinkan oleh sistem!');
        Get.defaultDialog(
          barrierDismissible: true,
          onWillPop: () async => false,
          title: "Pemberitahuan",
          content: Text(
            "Device anda terdeteksi FAKE GPS!!",
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          onConfirm: () {
            SystemNavigator.pop();
          },
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          buttonColor: Colors.blue,
          contentPadding: EdgeInsets.all(20),
          titlePadding: EdgeInsets.only(top: 20),
        );
      } else {
        print("FAKE tidak terdeteksi");
        getAddress();
      }
    });
  }

  Future<void> getAddress() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
      double.parse(latitude.value),
      double.parse(longitude.value),
    );
    Placemark place = placemark[0];
    address.value =
        "${place.street == "" ? "Jl. tidak diketahui" : place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  }

  void openCamer() async {
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      requestFullMetadata: true,
      imageQuality: 50,
    );
    if (image != null) {
      imagePath.value = image.path;
      Get.to(() => PriviewView());
    } else {
      print("Tidak ada gambar");
    }
  }

  Future dialogError(body) {
    return Get.defaultDialog(
      title: "Informasi",
      middleText: "${body}",
    );
  }
}
