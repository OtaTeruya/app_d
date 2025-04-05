import 'package:app_d/historyPage/view/widgets/calendar.dart';
import 'package:app_d/historyPage/view/widgets/photo_list.dart';
import 'package:flutter/material.dart';

import 'history_page.dart';

class HistoryPageUI extends StatelessWidget {
  final HistoryPageUIState uiState;
  final HistoryPageCallback callback;

  const HistoryPageUI({super.key, required this.uiState, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: ListView(
          children: [
            Calendar(selectedDate: uiState.selectedDate, callback: callback),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Text('${uiState.selectedDate.year}年${uiState.selectedDate.month}月${uiState.selectedDate.day}日'),
                  SizedBox(height: 8),
                  PhotoList(
                    photoPaths: uiState.photoPaths,
                    photoTimes: uiState.photoTimes,
                    photoTitles: uiState.photoTitles,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPageUIState {
  final DateTime selectedDate;
  final List<String>? photoPaths;
  final List<String>? photoTimes;
  final List<String>? photoTitles;

  HistoryPageUIState({
    required this.selectedDate,
    required this.photoPaths,
    required this.photoTimes,
    required this.photoTitles
  });
}
