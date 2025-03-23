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

  @override
  void moveToHomePage(BuildContext context) {
    context.go('/homePage');
  }

  @override
  void moveToHistoryPage(BuildContext context) {
    context.go('/historyPage');
  }

  @override
  void uiNoZyotaiWoHenkouSuruKansu() {//例です。好きな処理や名前に変えてください。
    setState(() {
      uiNoZyoutai1 = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CapturePageUI(
        uiState: CapturePageUIState(uiNoZyoutai1: uiNoZyoutai1, uiNoZyoutai2: uiNoZyoutai2),
        callback: this
    );
  }
}

abstract class CapturePageCallback {
  void moveToHomePage(BuildContext context);
  void moveToHistoryPage(BuildContext context);
  void uiNoZyotaiWoHenkouSuruKansu();
}