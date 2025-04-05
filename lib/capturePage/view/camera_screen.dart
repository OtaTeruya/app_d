import 'package:app_d/capturePage/view/camera_screen_ui.dart';
import 'package:app_d/capturePage/view/capture_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final CapturePageCallback callback;
  const CameraScreen({super.key, required this.callback});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> implements CameraScreenCallback {
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    setCamera();
  }

  void setCamera() async {
    // デバイスで使用可能なカメラのリストを取得
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }
    // 利用可能なカメラのリストから特定のカメラを取得
    final firstCamera = cameras.first;
    CameraController tmpCameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await tmpCameraController.initialize();
    if (!mounted) return; //widgetが破棄されてたら何もしない
    setState(() {
      cameraController = tmpCameraController;
    });
  }

  @override
  void dispose() {
    // ウィジェットが破棄されたら、コントローラーを破棄
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Future<void> onCaptured() async {
    if (cameraController == null) {
      return;
    }

    final image = await cameraController!.takePicture();
    widget.callback.moveToCheckScreen(image.path);
  }

  @override
  Widget build(BuildContext context) {
    // 画面の向きを取得
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (cameraController != null) {
      //カメラが存在する場合
      return CameraScreenUI(
        uiState: CameraScreenUIState(
            cameraController: cameraController!,
            isLandscape: isLandscape
        ),
        callback: this,
      );
    } else {
      //カメラが存在しない場合
      return Scaffold(
        body: Center(
            child: const Text(
              'カメラにアクセスできませんでした。',
              style: TextStyle(color: Colors.red),
            )
        ),
      );
    }
  }
}

abstract class CameraScreenCallback {
  void onCaptured();
}
