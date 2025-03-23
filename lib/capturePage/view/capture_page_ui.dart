import 'package:flutter/material.dart';

import '../../custom_app_bar.dart';
import 'capture_page.dart';

class CapturePageUI extends StatelessWidget {
  final CapturePageUIState uiState;
  final CapturePageCallback callback;

  const CapturePageUI({
    super.key,
    required this.uiState,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'CapturePage'),
        body:Center(
            child: Column(
                children: [
                  TextButton(
                      onPressed: () => callback.moveToHomePage(context),
                      child: Text('HomePageへ')
                  ),
                  TextButton(
                      onPressed: () => callback.moveToHistoryPage(context),
                      child: Text('HistoryPageへ')
                  )
                ]
            )
        )
    );
  }
}

class CapturePageUIState {
  final int uiNoZyoutai1;
  final String uiNoZyoutai2;

  CapturePageUIState({
    required this.uiNoZyoutai1,
    required this.uiNoZyoutai2
  });
}