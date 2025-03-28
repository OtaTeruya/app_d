import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'capture_page_ui.dart';

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePage();
}

class _CapturePage extends State<CapturePage> implements CapturePageCallback {
  int uiNoZyoutai1 = 0;
  String uiNoZyoutai2 = 'hoge';
  CameraDescription? camera;

  @override
  void initState() {
    super.initState();
    setCamera();
  }

  @override
  void moveToHomePage(BuildContext context) {
    context.go('/homePage');
  }

  @override
  void moveToHistoryPage(BuildContext context) {
    context.go('/historyPage');
  }

  @override
  void setCamera() async {
    //カメラの設定
    // デバイスで使用可能なカメラのリストを取得
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      setState(() {
        camera = null;
      });
      return;
    }
    // 利用可能なカメラのリストから特定のカメラを取得
    final firstCamera = cameras.first;
    // 取得できているか確認
    print(firstCamera);
    setState(() {
      camera = firstCamera;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CapturePageUI(
      // uiState: CapturePageUIState(
      //   isCurrentLocation: isCurrentLocation,
      // ),
      callback: this,
      camera: camera,
    );
  }
}

abstract class CapturePageCallback {
  void moveToHomePage(BuildContext context);
  void moveToHistoryPage(BuildContext context);
  void setCamera();
}
