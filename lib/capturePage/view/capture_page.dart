import 'package:flutter/cupertino.dart';

import '../../home/view/home.dart';
import 'capture_page_ui.dart';

class CapturePage extends StatefulWidget {
  final HomeCallback callback;
  const CapturePage({super.key, required this.callback});

  @override
  State<CapturePage> createState() => _CapturePage();
}

class _CapturePage extends State<CapturePage> implements CapturePageCallback {
  CapturePageScreen focusedScreen = CapturePageScreen.camera;
  String imgPath = "";
  String foodName = "";

  @override
  void moveToHistoryPage() {
    widget.callback.moveToHistoryPage();
  }

  @override
  void moveToCharacterPage() {
    widget.callback.moveToCharacterPage();
  }

  @override
  void moveToCameraScreen() {
    setState(() {
      focusedScreen = CapturePageScreen.camera;
    });
  }

  @override
  void moveToCheckScreen(String imgPath) {
    setState(() {
      this.imgPath = imgPath;
      focusedScreen = CapturePageScreen.check;
    });
  }

  @override
  void moveToResultScreen(String imgPath, String foodName) {
    setState(() {
      this.imgPath = imgPath;
      this.foodName = foodName;
      focusedScreen = CapturePageScreen.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CapturePageUI(
      uiState: CapturePageUIState(
          focusedScreen: focusedScreen,
          imgPath: imgPath,
          foodName: foodName
      ),
      callback: this,
    );
  }
}

abstract class CapturePageCallback {
  void moveToHistoryPage();
  void moveToCharacterPage();
  void moveToCameraScreen();
  void moveToCheckScreen(String imgPath);
  void moveToResultScreen(String imgPath, String foodName);
}

enum CapturePageScreen { camera, check, result }
