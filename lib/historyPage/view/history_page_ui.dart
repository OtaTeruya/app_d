import 'package:app_d/historyPage/view/widgets/calendar.dart';
import 'package:app_d/historyPage/view/widgets/photo_list.dart';
import 'package:app_d/historyPage/view/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'history_page.dart';

class HistoryPageUI extends StatelessWidget {
  final HistoryPageUIState uiState;
  final HistoryPageCallback callback;

  const HistoryPageUI({super.key, required this.uiState, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              Calendar(selectedDate: uiState.selectedDate, callback: callback),
              Gap(16),
              Text(
                '${uiState.selectedDate.month}月${uiState.selectedDate.day}日',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Gap(8),
              PhotoList(
                photoPaths: uiState.photoPaths,
                photoTimes: uiState.photoTimes,
                photoTitles: uiState.photoTitles,
                openPopup: callback.openPopup,
              )
            ],
          ),
          Visibility(
            visible: uiState.isPopupVisible,
            child: Popup(
              foodName: uiState.foodNameOnPopup,
              imgPath: uiState.imgPathOnPopup,
              callback: callback,
            ),
          ),
        ],)
    );
  }
}

class HistoryPageUIState {
  final DateTime selectedDate;
  final List<String>? photoPaths;
  final List<String>? photoTimes;
  final List<String>? photoTitles;
  final bool isPopupVisible;
  final String foodNameOnPopup;
  final String imgPathOnPopup;

  HistoryPageUIState({
    required this.selectedDate,
    required this.photoPaths,
    required this.photoTimes,
    required this.photoTitles,
    required this.isPopupVisible,
    required this.foodNameOnPopup,
    required this.imgPathOnPopup
  });
}
