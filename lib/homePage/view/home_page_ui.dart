import 'package:app_d/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_page.dart';

class HomePageUI extends StatelessWidget {
  final HomePageUIState uiState;
  final HomePageCallback callback;

  const HomePageUI({
    super.key,
    required this.uiState,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'HomePage'),
        body:Center(
            child: Column(
                children: [
                  TextButton(
                      onPressed: () => callback.moveToCapturePage(context),
                      child: Text('CapturePageへ')
                  ),
                  TextButton(
                      onPressed: () => callback.moveToHistoryPage(context),
                      child: Text('HistoryPageへ')
                  ),
                  TextButton(
                      onPressed: () => callback.moveToCharacterPage(context),
                      child: Text('CharacterPageへ')
                  ),
                  TextButton(
                      onPressed: () => context.go('/capturePage/captureResult?imgPath="hoge'),
                      child: Text('撮影結果へ')
                  )
                ]
            )
        )
    );
  }
}

class HomePageUIState {
  final int uiNoZyoutai1;
  final String uiNoZyoutai2;

  HomePageUIState({
    required this.uiNoZyoutai1,
    required this.uiNoZyoutai2
  });
}