import 'package:app_d/capturePage/view/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../custom_app_bar.dart';
import 'capture_page.dart';

class CapturePageUI extends StatelessWidget {
  // final CapturePageUIState uiState;
  final CapturePageCallback callback;
  final CameraDescription? camera;

  const CapturePageUI({
    super.key,
    // required this.uiState,
    required this.callback,
    required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    print(camera);
    if (camera != null) {
      //カメラが存在する場合
      return CameraScreen(camera: camera!);
    } else {
      //カメラが存在しない場合
      return Scaffold(
        appBar: CustomAppBar(title: '食事の撮影'),
        body: Center(
          child: Column(
            //カメラが存在しないことを表示
            children: [
              Gap(30),
              const Text(
                'カメラにアクセスすることができませんでした。',
                style: TextStyle(color: Colors.red),
              ),
              //帰らせる
              TextButton(
                onPressed: () => callback.moveToHomePage(context),
                child: Text('タイトル画面へ'),
              ),
            ],
          ),
        ),
      );
    }
  }
}

// class CapturePageUIState {
//   final bool isCurrentLocation;

//   CapturePageUIState({required this.isCurrentLocation,});
// }
