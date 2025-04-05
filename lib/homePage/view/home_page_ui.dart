import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../capturePage/view/capture_page.dart';
import '../../characterPage/view/character_page.dart';
import '../../historyPage/view/history_page.dart';
import 'home_page.dart';

class HomePageUI extends StatefulWidget {
  final HomePageDataState uiState;
  final HomePageCallback callback;

  const HomePageUI({super.key, required this.uiState, required this.callback});

  @override
  HomePageUIState createState() => HomePageUIState();
}

class HomePageUIState extends State<HomePageUI> {
  final tabBarHeight = 52.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  bottom: widget.uiState.isBottomBarTranslucent ? 0 : tabBarHeight
              ),
              child: IndexedStack(
                index: widget.uiState.focusedPageIndex,
                children: [
                  CapturePage(),
                  HistoryPage(),
                  CharacterPage(),
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
                            widget.callback.moveToCapturePage,
                            widget.callback.isFocused(AppPage.capture),
                            "images/icon_capture_focused.png",
                            "images/icon_capture_unfocused.png",
                            "撮影"
                        ),
                        _tabButton(
                            widget.callback.moveToHistoryPage,
                            widget.callback.isFocused(AppPage.history),
                            "images/icon_calendar_focused.png",
                            "images/icon_calendar_unfocused.png",
                            "記録"
                        ),
                        _tabButton(
                            widget.callback.moveToCharacterPage,
                            widget.callback.isFocused(AppPage.character),
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

class HomePageDataState {
  final int focusedPageIndex;
  final bool isBottomBarTranslucent;

  HomePageDataState({required this.focusedPageIndex, required this.isBottomBarTranslucent});
}
