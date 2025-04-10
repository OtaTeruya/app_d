import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;

class ImageManager {
  Future<void> saveImageIfNecessary(String imgPath, int rotationAngle) async {
    if (rotationAngle == 0) {
      return;//画像が回転されていない場合
    }

    final file = File(imgPath);
    if (!await file.exists()) {
      return;
    }

    final bytes = await file.readAsBytes();
    final originalImage = img.decodeImage(bytes);
    if (originalImage == null) {
      return;
    }

    // 角度に応じて回転
    img.Image rotatedImage = originalImage;
    switch (rotationAngle % 360) {
      case 90:
        rotatedImage = img.copyRotate(originalImage, angle: 90);
        break;
      case 180:
        rotatedImage = img.copyRotate(originalImage, angle: 180);
        break;
      case 270:
        rotatedImage = img.copyRotate(originalImage, angle: 270);
        break;
      default:
        return; // 想定外の角度は無視
    }

    // 上書き保存
    final encoded = img.encodeJpg(rotatedImage);
    await file.writeAsBytes(encoded);
  }

  //ファイルの存在は保証されていると仮定している
  Widget getImage(String imgPath) {
    final file = File(imgPath);
    final image = file.readAsBytesSync();
    return Image.memory(image, fit: BoxFit.contain);
  }
}