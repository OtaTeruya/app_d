import 'package:app_d/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class HomePageUI extends StatefulWidget {
  final HomePageDataState uiState;
  final HomePageCallback callback;

  const HomePageUI({super.key, required this.uiState, required this.callback});

  @override
  HomePageUIState createState() => HomePageUIState();
}

class HomePageUIState extends State<HomePageUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'HomePage'),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => widget.callback.moveToCapturePage(context),
              child: Text('CapturePageへ'),
            ),
            TextButton(
              onPressed: () => widget.callback.moveToHistoryPage(context),
              child: Text('HistoryPageへ'),
            ),
            TextButton(
              onPressed: () => widget.callback.moveToCharacterPage(context),
              child: Text('CharacterPageへ'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageDataState {
  final int uiNoZyoutai1;
  final String uiNoZyoutai2;

  HomePageDataState({required this.uiNoZyoutai1, required this.uiNoZyoutai2});
}
