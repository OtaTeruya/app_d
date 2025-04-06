import 'package:app_d/home/view/home.dart';
import 'package:flutter/material.dart';

import '../../database/record_dao.dart';
import 'history_page_ui.dart';

class HistoryPage extends StatefulWidget {
  final DateTime selectedDate;
  final HomeCallback callback;
  const HistoryPage({super.key, required this.selectedDate, required this.callback});

  @override
  State<HistoryPage> createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> implements HistoryPageCallback {
  List<String>? photoPaths;
  List<String>? photoTimes;
  List<String>? photoTitles;

  @override
  void initState() {
    super.initState();
    _onSelectedDateUpdated();
  }

  @override
  void didUpdateWidget(covariant HistoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      _onSelectedDateUpdated();
    }
  }

  Future<void> _onSelectedDateUpdated() async {
    int intDate = convertDateTimeToInt(widget.selectedDate);
    List<String> tmpPhotoPaths = await pickPhotoPaths(intDate);
    List<String> tmpPhotoTimes = await pickPhotoTimes(intDate);
    List<String> tmpPhotoTitles = await pickPhotoTitles(intDate);

    setState(() {
      photoPaths = tmpPhotoPaths;
      photoTimes = tmpPhotoTimes;
      photoTitles = tmpPhotoTitles;
    });
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
    widget.callback.setSelectedDate(date);
  }

  @override
  Widget build(BuildContext context) {
    return HistoryPageUI(
        uiState: HistoryPageUIState(
            selectedDate: widget.selectedDate,
            photoPaths: photoPaths,
            photoTimes: photoTimes,
            photoTitles: photoTitles
        ),
        callback: this
    );
  }
}

abstract class HistoryPageCallback {
  void selectDate(DateTime date);
}