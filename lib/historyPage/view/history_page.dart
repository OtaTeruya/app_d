import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'history_page_ui.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> implements HistoryPageCallback {
  int uiNoZyoutai1 = 0;
  String uiNoZyoutai2 = 'hoge';

  @override
  void moveToHomePage(BuildContext context) {
    context.go('/homePage');
  }

  @override
  void uiNoZyotaiWoHenkouSuruKansu() {//例です。好きな処理や名前に変えてください。
    setState(() {
      uiNoZyoutai1 = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HistoryPageUI(
        uiState: HistoryPageUIState(uiNoZyoutai1: uiNoZyoutai1, uiNoZyoutai2: uiNoZyoutai2),
        callback: this
    );
  }
}

abstract class HistoryPageCallback {
  void moveToHomePage(BuildContext context);
  void uiNoZyotaiWoHenkouSuruKansu();
}