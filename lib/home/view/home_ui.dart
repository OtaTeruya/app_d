import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../capturePage/view/capture_page.dart';
import '../../characterPage/view/character_page.dart';
import '../../historyPage/view/history_page.dart';
import 'home.dart';

class HomeUI extends StatelessWidget {
  final HomeUIState uiState;
  final HomeCallback callback;
  final tabBarHeight = 52.0;

  const HomeUI({super.key, required this.uiState, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      bottom: uiState.isBottomBarTranslucent ? 0 : tabBarHeight
                  ),
                  child: IndexedStack(
                    index: uiState.focusedPageIndex,
                    children: [
                      CapturePage(callback: callback),
                      HistoryPage(selectedDate: uiState.selectedDate, callback: callback),
                      CharacterPage(foodCount: uiState.foodCount, callback: callback),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Spacer(),
                    Container(
                        height: tabBarHeight,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            _tabButton(
                                callback.moveToCapturePage,
                                callback.isFocused(AppPage.capture),
                                "images/icon_capture_focused.png",
                                "images/icon_capture_unfocused.png",
                                "撮影"
                            ),
                            _tabButton(
                                callback.moveToHistoryPage,
                                callback.isFocused(AppPage.history),
                                "images/icon_calendar_focused.png",
                                "images/icon_calendar_unfocused.png",
                                "日記"
                            ),
                            _tabButton(
                                callback.moveToCharacterPage,
                                callback.isFocused(AppPage.character),
                                "images/icon_character_focused.png",
                                "images/icon_character_unfocused.png",
                                "育成"
                            ),
                          ],
                        )
                    )
                  ],
                )
              ],
            )
        )
    );
  }

  Widget _tabButton(
      VoidCallback onClicked, bool isFocused,
      String focusedImageAsset, String unFocusedImageAsset, String text) {
    return Expanded(
        child: ElevatedButton(
            onPressed: onClicked,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )
            ),
            child: Column(
                children: [
                  Gap(4),
                  Expanded(
                    child: Image.asset(
                      isFocused ? focusedImageAsset : unFocusedImageAsset,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 12,
                        color: isFocused ? Color(0xFF547F54) : Color(0xFF7F7F7F)
                    ),
                  ),
                ]
            )
        )
    );
  }
}

class HomeUIState {
  final int focusedPageIndex;
  final bool isBottomBarTranslucent;
  final DateTime selectedDate;
  final int? foodCount;

  HomeUIState({
    required this.focusedPageIndex,
    required this.isBottomBarTranslucent,
    required this.selectedDate,
    required this.foodCount
  });
}
