import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'home_page_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> implements HomePageCallback {
  int uiNoZyoutai1 = 0;
  String uiNoZyoutai2 = 'hoge';

  @override
  void moveToCapturePage(BuildContext context) {
    context.go('/capturePage');
  }

  @override
  void moveToCharacterPage(BuildContext context) {
    context.go('/characterPage');
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
    return HomePageUI(
        uiState: HomePageUIState(uiNoZyoutai1: uiNoZyoutai1, uiNoZyoutai2: uiNoZyoutai2),
        callback: this
    );
  }
}

abstract class HomePageCallback {
  void moveToCapturePage(BuildContext context);
  void moveToHistoryPage(BuildContext context);
  void moveToCharacterPage(BuildContext context);
  void uiNoZyotaiWoHenkouSuruKansu();
}