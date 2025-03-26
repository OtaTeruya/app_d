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
  State<CaptureResult> createState() => _CaptureResultState();
}

class _CaptureResultState extends State<CaptureResult> {
  bool? fileExists; // ファイルの存在状態を保持する変数
  final RecordDAO recordDAO = RecordDAO();
  String latestRecordText = "最新のデータ: なし";
  String recordsText = "特定の日付のデータ: なし";

  @override
  void initState() {
    super.initState();
    _checkFileExists(); // ファイルの存在を確認
    handleDatabaseOperations(); // データベース操作を初期化時に呼び出す
  }

  Future<void> _checkFileExists() async {
    final exists = await File(widget.imgPath).exists();
    setState(() {
      fileExists = exists; // 結果を State に保存
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.imgPath);
    return Scaffold(
      appBar: CustomAppBar(title: 'CapturePage'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Gap(10),
              Text("画像を確認して下さい"),
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
              Gap(20),
              fileExists !=
                      null //後で修正
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            File(widget.imgPath).delete();
                            print("ファイル削除：${widget.imgPath}");
                            context.replace('/capturePage');
                          },
                          style: TextButton.styleFrom(
                            side: BorderSide(color: Colors.blue),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: Text(
                            '撮り直す',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go(
                              '/capturePage/captureResult/mealForm?imgPath=${widget.imgPath}',
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: Text(
                            'これにする！',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                  : TextButton(
                    onPressed: () => context.go('/homePage'),
                    child: Text('HomePageへ'),
                  ),
              Gap(10),
            ],
          ),
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
