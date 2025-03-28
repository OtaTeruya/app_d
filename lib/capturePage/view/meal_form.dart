import 'dart:io';

import 'package:app_d/capturePage/component/reward_dialog.dart';
import 'package:app_d/characterPage/utils/food_manager.dart';
import 'package:app_d/custom_app_bar.dart';
import 'package:app_d/database/record_dao.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MealForm extends StatefulWidget {
  const MealForm({super.key, required this.imgPath, required this.foodName});
  final String imgPath;
  final String foodName;

  @override
  State<MealForm> createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  bool? fileExists; // ファイルの存在状態を保持する変数
  DateTime now = DateTime.now();
  final RecordDAO recordDAO = RecordDAO();
  String latestRecordText = "最新のデータ: なし";
  String recordsText = "特定の日付のデータ: なし";
  DateTime? initLatestRecordTime; //前回のデータの時間

  @override
  void initState() {
    super.initState();
    _checkFileExists(); // ファイルの存在を確認
    //handleDatabaseOperations(); // データベース操作を初期化時に呼び出す
    getLatestRecord(); // 前回のデータの時間を取得（最初だけ）
  }

  Future<void> _checkFileExists() async {
    final exists = await File(widget.imgPath).exists();
    setState(() {
      fileExists = exists; // 結果を State に保存
    });
  }

  // 前回のデータの時間を取得
  void getLatestRecord() async {
    var latestRecord = await recordDAO.getLatestRecord();
    if (latestRecord == null) {
      initLatestRecordTime = null;
      return;
    }
    int date = latestRecord['date'];
    int time = latestRecord['time'];
    initLatestRecordTime = DateTime(
      date ~/ 10000,
      (date % 10000) ~/ 100,
      date % 100,
      time ~/ 10000,
      (time % 10000) ~/ 100,
      time % 100,
    );
  }

  // 現在の日付、時刻をintで取得
  int getDateInt() {
    return now.year * 10000 + now.month * 100 + now.day;
  }

  int getTimeInt() {
    return now.hour * 10000 + now.minute * 100 + now.second;
  }

  //データベースに追加
  void addDataToDB(BuildContext context, String nextPath) async {
    if (fileExists == null || fileExists == false) {
      context.go(nextPath);
      return;
    }
    // データを保存する処理
    await recordDAO.insertRecord(widget.imgPath, getDateInt(), getTimeInt());

    // 最新のデータを取得
    var latestRecord = await recordDAO.getLatestRecord();
    latestRecordText = '最新のデータ: $latestRecord';
    print(latestRecordText);

    rewardHndling(nextPath);
  }

  // 報酬
  void rewardHndling(String nextPath) {
    if (initLatestRecordTime != null) {
      // 前回のデータの時間と今回のデータの時間の差を計算
      Duration diff = now.difference(initLatestRecordTime!);
      print('差: $diff');
      // 2時間以上経過していない場合は報酬を与えない
      if (diff.inHours < 2) {
        context.go(nextPath);
        return;
      }
    }
    // 報酬を与える処理
    FoodManager().addSavedFoodCount();
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return RewardDialog(nextPath: nextPath);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'CapturePage'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Gap(10),
              Center(
                child: Text(
                  "${now.year.toString()}年${now.month.toString()}月${now.day.toString()}日",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "命名: ${widget.foodName}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600,),
                  ),
                ),
              ),
              Divider(),
              SizedBox(
                height: 320,
                child:
                    fileExists == null
                        ? const Center(
                          child: CircularProgressIndicator(),
                        ) // ローディング中
                        : fileExists == true
                        ? Image.file(File(widget.imgPath)) // ファイルが存在する場合
                        : const Center(
                          child: Text("データが存在しません"),
                        ), // ファイルが存在しない場合
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () async {
                      addDataToDB(context, '/homePage');
                    },
                    child: Text('HomePageへ'),
                  ),
                  TextButton(
                    onPressed: () {
                      addDataToDB(context, '/historyPage');
                    },
                    child: Text('HistoryPageへ'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //    Future<void> handleDatabaseOperations() async {
  //     DateTime now = DateTime.now();
  //     int date = int.parse(
  //       '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}',
  //     ); // YYYYMMDD形式
  //     int time = int.parse(
  //       '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}',
  //     ); // HHMM形式
  //     print(widget.imgPath);
  //     String imgPath = widget.imgPath;
  //     print('日付: $date');
  //     print('時刻: $time');
  //     // データを追加
  //     await recordDAO.insertRecord(imgPath, date, time);

  //     // 最新のデータを取得
  //     var latestRecord = await recordDAO.getLatestRecord();

  //     // 特定の日付のデータを取得
  //     var records = await recordDAO.getRecordsByDate(20250330);

  //     latestRecordText = '最新のデータ: $latestRecord';
  //     recordsText = '2025年3月31日のデータ: $records';

  //     print(latestRecordText);
  //     print(recordsText);
  //   }
}
