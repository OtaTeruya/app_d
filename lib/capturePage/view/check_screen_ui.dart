import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'check_screen.dart';

class CheckScreenUI extends StatelessWidget {
  final CheckScreenCallback callback;
  final CheckScreenUIState uiState;

  const CheckScreenUI({
    super.key,
    required this.uiState,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: uiState.geminiSuccess ? _geminiAnswer(uiState) : Center(
        //geminiが正しい返答を返さなかった場合
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '時間をおいてもう一度お試しいただくか、ご利用の環境をご確認ください。',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: callback.recapture,
              child: Text('撮り直す'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _geminiAnswer(CheckScreenUIState uiState) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Gap(10),
            uiState.isFood == null
                ? CircularProgressIndicator()
                : uiState.isFood == true
                ? Text("画像を確認して下さい")
                : Text("食べ物を撮影して下さい"),
            Divider(),
            SizedBox(
              height: 320,
              child:
              uiState.fileExists == null
                  ? const Center(
                child: CircularProgressIndicator(),
              ) // ローディング中
                  : uiState.fileExists == true
                  ? Image.file(
                File(uiState.imgPath),
              ) // ファイルが存在する場合
                  : const Center(
                child: Text("データが存在しません"),
              ), // ファイルが存在しない場合
            ),
            Gap(20),
            uiState.fileExists == true
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: callback.recapture,
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Colors.blue),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                    child: Text(
                      '撮り直す',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  uiState.isFood == true
                      ? TextButton(
                    onPressed: () {callback.moveToResultScreen();},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                    child: Text(
                      'これにする！',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                      : SizedBox(),
                ],
              ),
            )
                : TextButton(
              onPressed: callback.recapture,
              child: Text('撮り直す'),
            ),
            Gap(10),
          ],
        ),
      ),
    );
  }
}

class CheckScreenUIState {
  String imgPath;
  bool? fileExists;
  bool? isFood;
  String foodName;
  bool geminiSuccess;

  CheckScreenUIState({
    required this.imgPath,
    required this.fileExists,
    required this.isFood,
    required this.foodName,
    required this.geminiSuccess
  });
}