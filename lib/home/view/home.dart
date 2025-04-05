import 'package:flutter/cupertino.dart';

import 'home_ui.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> implements HomeCallback {
  int focusedPageIndex = AppPage.values.indexOf(AppPage.history);
  bool isBottomBarTranslucent = false;

  @override
  void moveToCapturePage() {
    setState(() {
      focusedPageIndex = AppPage.values.indexOf(AppPage.capture);
    });
  }

  @override
  void moveToHistoryPage() {
    setState(() {
      focusedPageIndex = AppPage.values.indexOf(AppPage.history);
    });
  }

  @override
  void moveToCharacterPage() {
    setState(() {
      focusedPageIndex = AppPage.values.indexOf(AppPage.character);
    });
  }

  @override
  bool isFocused(AppPage appPage) {
    return focusedPageIndex == AppPage.values.indexOf(appPage);
  }

  @override
  Widget build(BuildContext context) {
    return HomeUI(
      uiState: HomeUIState(
          focusedPageIndex: focusedPageIndex,
          isBottomBarTranslucent: isBottomBarTranslucent
      ),
      callback: this,//赤線が引かれているが問題ない
    );
  }
}

abstract class HomeCallback {
  void moveToCapturePage();
  void moveToHistoryPage();
  void moveToCharacterPage();
  bool isFocused(AppPage appPage);
}

enum AppPage { capture, history, character }