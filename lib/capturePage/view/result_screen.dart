import 'dart:io';

import 'package:app_d/capturePage/components/reward_dialog.dart';
import 'package:app_d/capturePage/view/result_screen_ui.dart';
import 'package:app_d/characterPage/utils/food_manager.dart';
import 'package:app_d/database/record_dao.dart';
import 'package:flutter/material.dart';

import 'capture_page.dart';

class ResultScreen extends StatefulWidget {
  final String imgPath;
  final String foodName;
  final CapturePageCallback callback;
  const ResultScreen({super.key, required this.imgPath, required this.foodName, required this.callback});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> implements ResultScreenCallback {
  bool? fileExists;
  DateTime now = DateTime.now();
  final RecordDAO recordDAO = RecordDAO();

  @override
  void initState() {
    super.initState();
    _rewardHandling((bool isFoodGot) {
      if (isFoodGot) {
        widget.callback.updateCharacterPage();
      }
      _addDataToDB(() {
        widget.callback.updateHistoryPage();
      });
    });
    _checkFileExists();
  }

  Future<void> _rewardHandling(Function(bool) completion) async {
    // 報酬を与える処理
    bool isFoodAdded = await FoodManager().addSavedFoodCount();

    if (!isFoodAdded) {
      completion(false);
      return;
    }

    if (!mounted) {//上の処理を行なっている間に破棄されていたら
      completion(false);
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return RewardDialog(moveToCharacterPage: widget.callback.moveToCharacterPage);
      },
    );
    completion(true);
  }

  //データベースに追加
  void _addDataToDB(VoidCallback completion) async {
    await recordDAO.insertRecord(
      widget.imgPath,
      _getDateInt(),
      _getTimeInt(),
      widget.foodName,
    );
    completion();
  }

  // 現在の日付、時刻をintで取得
  int _getDateInt() {
    return now.year * 10000 + now.month * 100 + now.day;
  }

  int _getTimeInt() {
    return now.hour * 10000 + now.minute * 100 + now.second;
  }

  Future<void> _checkFileExists() async {
    final exists = await File(widget.imgPath).exists();
    setState(() {
      fileExists = exists;
    });
  }

  @override
  void moveToCameraScreen() {
    widget.callback.moveToCameraScreen();
  }

  @override
  void moveToHistoryPage() {
    widget.callback.moveToHistoryPage();
  }

  @override
  Widget build(BuildContext context) {
    return ResultScreenUI(
        uiState: ResultScreenUIState(
            imgPath: widget.imgPath,
            fileExists: fileExists,
            now: now,
            foodName: widget.foodName
        ),
        callback: this
    );
  }
}

abstract class ResultScreenCallback {
  void moveToCameraScreen();
  void moveToHistoryPage();
}
