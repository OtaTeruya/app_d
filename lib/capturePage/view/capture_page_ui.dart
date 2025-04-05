import 'package:app_d/capturePage/view/camera_screen.dart';
import 'package:app_d/capturePage/view/check_screen.dart';
import 'package:app_d/capturePage/view/result_screen.dart';
import 'package:flutter/material.dart';

import 'capture_page.dart';

class CapturePageUI extends StatelessWidget {
  final CapturePageUIState uiState;
  final CapturePageCallback callback;

  const CapturePageUI({
    super.key,
    required this.uiState,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    switch (uiState.focusedScreen) {
      case CapturePageScreen.camera:
        return CameraScreen(callback: callback);
      case CapturePageScreen.check:
        return CheckScreen(imgPath: uiState.imgPath, callback: callback);
      case CapturePageScreen.result:
        return ResultScreen(imgPath: uiState.imgPath, foodName: uiState.foodName, callback: callback);
      }
  }
}

 class CapturePageUIState {
   final CapturePageScreen focusedScreen;
   final String imgPath;
   final String foodName;

   CapturePageUIState({
     required this.focusedScreen,
     required this.imgPath,
     required this.foodName
   });
}
