import 'package:flutter/material.dart';

import '../../capturePage/utils/image_manager.dart';
import '../../database/record_dao.dart';
import 'history_page_ui.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> implements HistoryPageCallback {
  //calendar用
  DateTime selectedDate = DateTime.now();

  //photo_list用
  List<String>? photoPaths;
  List<String>? photoTimes;
  List<String>? photoTitles;

  //popup用
  bool isPopupVisible = false;
  String foodNameOnPopup = "";
  String imgPathOnPopup = "";

  bool isProcessing = false;

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
  void openPopup(String foodName, String imgPath) {
    setState(() {
      isPopupVisible = true;
      foodNameOnPopup = foodName;
      imgPathOnPopup = imgPath;
    });
  }

  @override
  Future<void> deleteImageOnPopup() async {
    if (isProcessing) {
      return;
    }
    isProcessing = true;

    await RecordDAO().deleteRecordByPath(imgPathOnPopup);
    ImageManager().deleteImage(imgPathOnPopup);
    await selectDate(selectedDate);
    setState(() {
      isPopupVisible = false;
    });

    isProcessing = false;
  }

  @override
  Future<void> closePopup(int rotationAngle) async {
    if (isProcessing) {
      return;
    }
    isProcessing = true;

    await ImageManager().saveImageIfNecessary(imgPathOnPopup, rotationAngle);
    setState(() {
      isPopupVisible = false;
    });

    isProcessing = false;
  }

  @override
  Widget build(BuildContext context) {
    return HistoryPageUI(
        uiState: HistoryPageUIState(
            selectedDate: selectedDate,
            photoPaths: photoPaths,
            photoTimes: photoTimes,
            photoTitles: photoTitles,
            isPopupVisible: isPopupVisible,
            foodNameOnPopup: foodNameOnPopup,
            imgPathOnPopup: imgPathOnPopup
        ),
        callback: this
    );
  }
}

abstract class HistoryPageCallback {
  Future<void> selectDate(DateTime date);
  void openPopup(String foodName, String imgPath);
  Future<void> deleteImageOnPopup();
  Future<void> closePopup(int rotationAngle);
}