import 'package:flutter/material.dart';

import '../../database/record_dao.dart';
import 'history_page_ui.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> implements HistoryPageCallback {
  DateTime selectedDate = DateTime.now();
  List<String>? photoPaths;
  List<String>? photoTimes;
  List<String>? photoTitles;

  @override
  void initState() {
    super.initState();
    selectDate(selectedDate);
  }

  int convertDateTimeToInt(DateTime dateTime) {
    int date = int.parse(
      '${dateTime.year}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}',
    );
    return date;
  }

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

  Future<List<String>> pickPhotoTitles(int date) async {
    var records = await RecordDAO().getRecordsByDate(date);
    List<String> photoTitles = [];
    for (var record in records) {
      photoTitles.add(record['cuisine']);
    }
    return photoTitles;
  }

  @override
  Future<void> selectDate(DateTime date) async {
    int intDate = convertDateTimeToInt(date);
    List<String> tmpPhotoPaths = await pickPhotoPaths(intDate);
    List<String> tmpPhotoTimes = await pickPhotoTimes(intDate);
    List<String> tmpPhotoTitles = await pickPhotoTitles(intDate);

    setState(() {
      selectedDate = date;
      photoPaths = tmpPhotoPaths;
      photoTimes = tmpPhotoTimes;
      photoTitles = tmpPhotoTitles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HistoryPageUI(
        uiState: HistoryPageUIState(
            selectedDate: selectedDate,
            photoPaths: photoPaths,
            photoTimes: photoTimes,
            photoTitles: photoTitles
        ),
        callback: this
    );
  }
}

abstract class HistoryPageCallback {
  Future<void> selectDate(DateTime date);
}