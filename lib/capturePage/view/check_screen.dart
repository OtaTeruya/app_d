import 'dart:io';

import 'package:app_d/capturePage/utils/judge_food.dart';
import 'package:app_d/capturePage/view/check_screen_ui.dart';
import 'package:flutter/material.dart';

import 'capture_page.dart';

class CheckScreen extends StatefulWidget {
  final String imgPath;
  final CapturePageCallback callback;
  const CheckScreen({super.key, required this.imgPath, required this.callback});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> implements CheckScreenCallback {
  bool? fileExists;
  bool? isFood;
  String foodName = '';
  bool geminiSuccess = true;

  @override
  void initState() {
    super.initState();
    _checkFileExists();
    _askGemini();
  }

  Future<void> _checkFileExists() async {
    final exists = await File(widget.imgPath).exists();
    setState(() {
      fileExists = exists;
    });
  }

  // Geminiに画像を問い合わせる
  void _askGemini() async {
    String result = await JudgeFood().judge(
      widget.imgPath,
    ); // result = '食べ物か,信頼度,料理名';
    print('Gemini結果：$result');
    if (result == 'Gemini返答失敗' || result == 'Geminiエラー') {
      setState(() {
        geminiSuccess = false;
      });
      return;
    }
    List<String> resultList = result.split(',');
    setState(() {
      isFood = resultList[0] == 'Yes' ? true : false;
      foodName = resultList[2].trimRight();
      geminiSuccess = true;
    });
    return;
  }

  @override
  void recapture() {
    File(widget.imgPath).delete();
    widget.callback.moveToCameraScreen();
  }

  @override
  void moveToResultScreen() {
    widget.callback.moveToResultScreen(widget.imgPath, foodName);
  }

  @override
  Widget build(BuildContext context) {
    return CheckScreenUI(
        uiState: CheckScreenUIState(
            imgPath: widget.imgPath,
            fileExists: fileExists,
            isFood: isFood,
            foodName: foodName,
            geminiSuccess: geminiSuccess
        ),
        callback: this
    );
  }
}

abstract class CheckScreenCallback {
  void recapture();
  void moveToResultScreen();
}
