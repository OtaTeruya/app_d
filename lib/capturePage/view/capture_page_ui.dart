import 'package:app_d/capturePage/view/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../custom_app_bar.dart';
import 'capture_page.dart';

class CapturePageUI extends StatelessWidget {
  final CapturePageUIState uiState;
  final CapturePageCallback callback;
  final CameraDescription? camera;

  const CapturePageUI({
    super.key,
    required this.uiState,
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
        appBar: CustomAppBar(title: 'CapturePage'),
        body: Center(
          child: Column(
            //カメラが存在しないことを表示
            children: [
              Gap(30),
              const Text(
                'カメラが見つかりませんでした。',
                style: TextStyle(color: Colors.red),
              ),
              //帰らせる
              TextButton(
                onPressed: () => callback.moveToHistoryPage(context),
                child: Text('HistoryPageへ'),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class CapturePageUIState {
  final int uiNoZyoutai1;
  final String uiNoZyoutai2;

  CapturePageUIState({required this.uiNoZyoutai1, required this.uiNoZyoutai2});
}
