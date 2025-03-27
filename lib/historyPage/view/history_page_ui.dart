import 'package:app_d/database/record_dao.dart';
import 'package:app_d/historyPage/view/widgets/calendar.dart';
import 'package:app_d/historyPage/view/widgets/photo_list.dart';
import 'package:flutter/material.dart';

import '../../custom_app_bar.dart';
import 'history_page.dart';

class HistoryPageUI extends StatelessWidget {
  final HistoryPageUIState uiState;
  final HistoryPageCallback callback;
  final ValueNotifier<DateTime> _selectedDate = ValueNotifier(DateTime.now());

  HistoryPageUI({super.key, required this.uiState, required this.callback});

  Future<List<String>> pickPhotoPaths(int date) async {
    var records = await RecordDAO().getRecordsByDate(date);
    List<String> photoPaths = [];
    for (var record in records) {
      photoPaths.add(record['path']);
    }
    return photoPaths;
  }

  Future<List<String>> pickPhotoTimes(int date) async {
    var records = await RecordDAO().getRecordsByDate(date);
    List<String> photoTimes = [];
    for (var record in records) {
      int time = record['time'];
      int hour = time ~/ 10000;
      int minute = time ~/ 100 - hour * 100;
      photoTimes.add('$hour:${minute.toString().padLeft(2, '0')}');
    }
    return photoTimes;
  }

  int convertDateTimeToInt(DateTime dateTime) {
    int date = int.parse(
      '${dateTime.year}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}',
    );
    return date;
  }

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
            Calendar(selectedDate: _selectedDate),
            Center(
              child: ValueListenableBuilder<DateTime>(
                valueListenable: _selectedDate,
                builder: (context, date, child) {
                  return FutureBuilder<List<dynamic>>(
                    future: Future.wait([
                      pickPhotoPaths(convertDateTimeToInt(date)), // 写真のパス取得
                      pickPhotoTimes(convertDateTimeToInt(date)), // 撮影時間取得
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> photoPaths = snapshot.data?[0] ?? [];
                        List<String> photoTimes = snapshot.data?[1] ?? [];
                        return Column(
                          children: [
                            Text('${date.year}年${date.month}月${date.day}日'),
                            SizedBox(height: 8),
                            PhotoList(
                              photoPaths: photoPaths,
                              photoTimes: photoTimes,
                            ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
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
