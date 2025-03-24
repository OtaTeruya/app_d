import 'package:app_d/historyPage/view/widgets/calendar.dart';
import 'package:flutter/material.dart';

import '../../custom_app_bar.dart';
import 'history_page.dart';

class HistoryPageUI extends StatelessWidget {
  final HistoryPageUIState uiState;
  final HistoryPageCallback callback;

  const HistoryPageUI({
    super.key,
    required this.uiState,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'HistoryPage'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            TextButton(
              onPressed: () => callback.moveToHomePage(context),
              child: Text('HomePageへ'),
            ),
            Calendar(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class HistoryPageUIState {
  final int uiNoZyoutai1;
  final String uiNoZyoutai2;

  HistoryPageUIState({required this.uiNoZyoutai1, required this.uiNoZyoutai2});
}
