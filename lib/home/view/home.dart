import 'package:app_d/capturePage/view/capture_page.dart';
import 'package:app_d/characterPage/view/character_page.dart';
import 'package:app_d/historyPage/view/history_page.dart';
import 'package:flutter/cupertino.dart';

import 'home_ui.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> implements HomeCallback {
  int focusedPageIndex = AppPage.values.indexOf(AppPage.history);
  bool isCameraUsing = true;
  late List<StatefulWidget> pages;

  @override
  void initState() {
    super.initState();
    pages = [CapturePage(callback: this), HistoryPage(), CharacterPage()];
  }

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
  void setIsCameraUsing(bool value) {
    setState(() {
      isCameraUsing = value;
    });
  } 

  @override
  void updateHistoryPage() {
    setState(() {
      //keyを指定して別物とすることで、再描画を走らせる
      pages[1] = HistoryPage(key: UniqueKey());
    });
  }

  @override
  void updateCharacterPage() {
    setState(() {
      //keyを指定して別物とすることで、再描画を走らせる
      pages[2] = CharacterPage(key: UniqueKey());
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeUI(
      uiState: HomeUIState(
          focusedPageIndex: focusedPageIndex,
          isBottomBarTranslucent: isCameraUsing && isFocused(AppPage.capture),
          pages: pages
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
  void setIsCameraUsing(bool value);
  void updateHistoryPage();
  void updateCharacterPage();
}

enum AppPage { capture, history, character }