import 'package:flutter/cupertino.dart';

import '../../characterPage/utils/food_manager.dart';
import 'home_ui.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> implements HomeCallback {
  int focusedPageIndex = AppPage.values.indexOf(AppPage.history);
  bool isBottomBarTranslucent = false;

  //HistoryPageの再描画を制御するために知っておく必要のある変数
  DateTime selectedDate = DateTime.now();

  //CharacterPageの再描画を制御するために知っておく必要のある変数
  int? foodCount;

  @override
  void initState() {
    super.initState();
    _loadFoodCount();
  }

  Future<void> _loadFoodCount() async {
    final cnt = await FoodManager().loadFoodCount();
    setState(() {
      foodCount = cnt;
    });
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
  void moveToHistoryPageWithDate(DateTime date) {
    setState(() {
      selectedDate = date;
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
  void setSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  void updateHistoryPageByAddingData(DateTime date) {
    if (selectedDate.year == date.year && selectedDate.month == date.month && selectedDate.day == date.day) {
      setSelectedDate(date);//同じ日付が選ばれていれば、データ追加を反映するために、UIの再描画を呼び出す
    }
  }

  @override
  void updateCharacterPageByGettingFood() {
    if (foodCount == null) {
      return;
    }
    setState(() {
      foodCount = foodCount! + 1;
    });
  }

  @override
  void updateCharacterPageByEatingFood() {
    if (foodCount == null) {
      return;
    }
    setState(() {
      foodCount = foodCount! - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeUI(
      uiState: HomeUIState(
          focusedPageIndex: focusedPageIndex,
          isBottomBarTranslucent: isBottomBarTranslucent,
          selectedDate: selectedDate,
          foodCount: foodCount
      ),
      callback: this,//赤線が引かれているが問題ない
    );
  }
}

abstract class HomeCallback {
  void moveToCapturePage();
  void moveToHistoryPage();
  void moveToHistoryPageWithDate(DateTime date);
  void moveToCharacterPage();
  bool isFocused(AppPage appPage);
  void setSelectedDate(DateTime date);
  void updateHistoryPageByAddingData(DateTime date);
  void updateCharacterPageByGettingFood();
  void updateCharacterPageByEatingFood();
}

enum AppPage { capture, history, character }