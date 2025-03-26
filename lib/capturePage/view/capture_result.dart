import 'dart:io';

import 'package:app_d/custom_app_bar.dart';
import 'package:app_d/database/record_dao.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CaptureResult extends StatefulWidget {
  const CaptureResult({super.key, required this.imgPath});
  final String imgPath;

  @override
  CaptureResultState createState() => CaptureResultState();
}

class CaptureResultState extends State<CaptureResult> {
  final RecordDAO recordDAO = RecordDAO();
  String latestRecordText = "最新のデータ: なし";
  String recordsText = "特定の日付のデータ: なし";

  @override
  void initState() {
    super.initState();
    handleDatabaseOperations(); // データベース操作を初期化時に呼び出す
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'CapturePage'),
      body: Center(
        child: Column(
          children: [
            Gap(10),
            SizedBox(height: 320, child: Image.file(File(widget.imgPath))),
            Gap(20),
            TextButton(
              onPressed: () => context.go('/homePage'),
              child: Text('HomePageへ'),
            ),
            TextButton(
              onPressed: () => context.go('/historyPage'),
              child: Text('HistoryPageへ'),
            ),
            Text(latestRecordText),
            Text(recordsText),
          ],
        ),
      ),
    );
  }

  Future<void> handleDatabaseOperations() async {
    DateTime now = DateTime.now();
    int date = int.parse(
      '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}',
    ); // YYYYMMDD形式
    int time = int.parse(
      '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}',
    ); // HHMM形式
    print(widget.imgPath);
    String imgPath = widget.imgPath;
    print('日付: $date');
    print('時刻: $time');
    // データを追加
    await recordDAO.insertRecord(imgPath, date, time);

    // 最新のデータを取得
    var latestRecord = await recordDAO.getLatestRecord();

    // 特定の日付のデータを取得
    var records = await recordDAO.getRecordsByDate(20250330);

    latestRecordText = '最新のデータ: $latestRecord';
    recordsText = '2025年3月31日のデータ: $records';

    print(latestRecordText);
    print(recordsText);
  }
}
