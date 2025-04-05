import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_d/capturePage/view/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResultScreenUI extends StatelessWidget {
  final ResultScreenCallback callback;
  final ResultScreenUIState uiState;

  const ResultScreenUI({
    super.key,
    required this.uiState,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Gap(10),
              Center(
                child: Text(
                  "${uiState.now.year.toString()}年${uiState.now.month.toString()}月${uiState.now.day.toString()}日",
                  style: const TextStyle(fontSize: 20),
                )
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        uiState.foodName,
                        textStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ),
              ),
              Divider(),
              SizedBox(
                height: 320,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child:
                  uiState.fileExists == null
                      ? const Center(
                    child: CircularProgressIndicator(),
                  ) // ローディング中
                      : uiState.fileExists == true
                      ? Image.file(File(uiState.imgPath)) // ファイルが存在する場合
                      : const Center(
                    child: Text("データが存在しません"),
                  ), // ファイルが存在しない場合
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: callback.moveToCameraScreen,
                    child: Text('もう一枚撮る'),
                  ),
                  TextButton(
                    onPressed: callback.moveToHistoryPage,
                    child: Text('日記を見る'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreenUIState {
  String imgPath;
  bool? fileExists;
  DateTime now;
  String foodName;

  ResultScreenUIState({
    required this.imgPath,
    required this.fileExists,
    required this.now,
    required this.foodName
  });
}