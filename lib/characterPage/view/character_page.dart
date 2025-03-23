import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'character_page_ui.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPage();
}

class _CharacterPage extends State<CharacterPage> implements CharacterPageCallback {
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
    return CharacterPageUI(
        uiState: CharacterPageUIState(uiNoZyoutai1: uiNoZyoutai1, uiNoZyoutai2: uiNoZyoutai2),
        callback: this
    );
  }
}

abstract class CharacterPageCallback {
  void moveToHomePage(BuildContext context);
  void uiNoZyotaiWoHenkouSuruKansu();
}