import 'package:app_d/capturePage/component/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: CustomAppBar(title: 'CapturePage'),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => callback.moveToHomePage(context),
              child: Text('HomePageへ'),
            ),
            TextButton(
              onPressed: () => callback.moveToHistoryPage(context),
              child: Text('HistoryPageへ'),
            ),
            camera != null
                ? Expanded(child: CameraScreen(camera: camera!))
                : const Text('カメラが見つかりませんでした'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Colors.white,
          shape: CircleBorder(),
          child: const Icon(Icons.camera, color: Colors.black, size: 50),
        ),
      ),
    );
  }
}

class CapturePageUIState {
  final int uiNoZyoutai1;
  final String uiNoZyoutai2;

  CapturePageUIState({required this.uiNoZyoutai1, required this.uiNoZyoutai2});
}
