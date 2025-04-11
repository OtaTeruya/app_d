import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_screen.dart';

class CameraScreenUI extends StatelessWidget {
  final CameraScreenCallback callback;
  final CameraScreenUIState uiState;

  const CameraScreenUI({
    super.key,
    required this.uiState,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CameraPreview(uiState.cameraController)
      ),
      //撮影のボタン
      floatingActionButtonLocation:
      uiState.isLandscape
          ? RightCenterFloatingActionButtonLocation() // 横向きの場合は右中央
          : FloatingActionButtonLocation.centerDocked, // 縦向きの場合は中央下部
      floatingActionButton: Padding(
        padding:
        uiState.isLandscape
            ? const EdgeInsets.only(bottom: 0)
            : const EdgeInsets.only(bottom: 8 + 52),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: callback.onCaptured,
            backgroundColor: Colors.white,
            shape: CircleBorder(),
            child: const Icon(Icons.camera, color: Colors.black, size: 50),
          ),
        ),
      ),
    );
  }
}

class RightCenterFloatingActionButtonLocation
    extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX =
        scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width -
            16; // 右端から16pxの余白
    final double fabY =
        (scaffoldGeometry.scaffoldSize.height -
            scaffoldGeometry.floatingActionButtonSize.height) /
            2; // 垂直方向の中央
    return Offset(fabX, fabY);
  }
}

class CameraScreenUIState {
  final CameraController cameraController;
  bool isLandscape;

  CameraScreenUIState({required this.cameraController, required this.isLandscape});
}
