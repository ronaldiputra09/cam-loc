import 'dart:async';
import 'dart:io';

import 'package:camera_geo/app/helpers/ad_helper.dart';
import 'package:camera_geo/app/modules/home/views/priview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class HomeController extends GetxController {
  final imagePicker = ImagePicker();
  var imagePath = "".obs;
  var tanggal = DateTime.now();
  var latitude = "".obs;
  var longitude = "".obs;
  var address = "".obs;
  var isSave = false.obs;
  var isShow = false.obs;
  var usernameC = TextEditingController();
  var passwordC = TextEditingController();
  StreamSubscription<Position>? streamSubscription;
  WidgetsToImageController widgetToImageC = WidgetsToImageController();
  Uint8List? bytes;

  BannerAd? bannerAd;

  @override
  void onInit() async {
    getLocation();
    BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Ad loaded.');
          bannerAd = ad as BannerAd?;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
      ),
      request: AdRequest(),
    ).load();
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
    bannerAd?.dispose();
    super.dispose();
  }

  // show password
  void showPassword() {
    isShow.value = !isShow.value;
  }

  void saveToGallery() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    final bytes = await widgetToImageC.capture();
    var exportToJpg =
        File('${dir}/image_${DateTime.now()}.jpg').writeAsBytes(bytes!);
    exportToJpg.then(
      (value) {
        GallerySaver.saveImage(value.path).then(
          (value1) {
            Get.defaultDialog(
              title: "Berhasil",
              middleText: "Gambar berhasil disimpan ke gallery",
              confirmTextColor: Colors.white,
              textConfirm: "Buka",
              onConfirm: () {
                Get.back();
                isSave.value = true;
                OpenFilex.open(value.path);
              },
            );
          },
        );
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
            "Device anda terdeteksi FAKE GPS!! \n Panik Ga?",
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
        "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  }

  void openCamer() async {
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      requestFullMetadata: true,
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
