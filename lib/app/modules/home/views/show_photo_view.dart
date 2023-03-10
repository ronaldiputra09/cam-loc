import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:camera_geo/app/data/themes.dart';

class ShowPhotoView extends GetView {
  const ShowPhotoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Lihat Foto',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(Get.arguments),
        basePosition: Alignment.center,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Text(
            "Gagal memuat gambar",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
