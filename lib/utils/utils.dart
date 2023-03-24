import 'dart:io';
import 'dart:typed_data';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

class AppUtils {
  const AppUtils._();

  //Pick Image
  static Future<dynamic> pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: imageSource, imageQuality: 50);
  }

  //Capture image from widget
  static Future<void> captureImage(key) async {
    final RenderRepaintBoundary boundary =
        key.currentContext.findRenderObject();

    final ui.Image image = await boundary.toImage(pixelRatio: 10.0);

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List? pngBytes = byteData?.buffer.asUint8List();

    await getStoragePermission();
    var path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    File imgFile = File('$path/${DateTime.now()}.png');
    imgFile.writeAsBytes(pngBytes as List<int>);
  }

  static Future<Uint8List?> getImageIntList(
      RenderRepaintBoundary renderRepaintBoundary) async {
    final ui.Image image = await renderRepaintBoundary.toImage();

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData?.buffer.asUint8List();
  }

  //Get storage permission
  static Future<void> getStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  //Get camera permission
  static Future<void> getCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  //
  static Future<void> getGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  //Show snackBar
  static showSnackBar({context, message}) {
    const snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: Text('Downloaded!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
