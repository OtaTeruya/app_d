import 'package:flutter/cupertino.dart';

import 'home_page_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> implements HomePageCallback {
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
    return HomePageUI(
      uiState: HomePageDataState(
          focusedPageIndex: focusedPageIndex,
          isBottomBarTranslucent: isBottomBarTranslucent
      ),
      callback: this,
    );
  }
}

abstract class HomePageCallback {
  void moveToCapturePage();
  void moveToHistoryPage();
  void moveToCharacterPage();
  bool isFocused(AppPage appPage);
}

enum AppPage { capture, history, character }