import 'dart:io';

import 'package:app_d/capturePage/component/judge_food.dart';
import 'package:app_d/custom_app_bar.dart';
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
  bool? isFood; // 食べ物かどうか
  String foodName = ''; // 料理名
  bool geminiSuccess = true; // Gemini問い合わせ成功か

  @override
  void initState() {
    super.initState();
    _checkFileExists(); // ファイルの存在を確認
    print("表示:${widget.imgPath}");
    print('Gemini問い合わせ');
    askGemini();
  }

  Future<void> _checkFileExists() async {
    final exists = await File(widget.imgPath).exists();
    setState(() {
      fileExists = exists; // 結果を State に保存
    });
  }

  // Geminiに画像を問い合わせる
  void askGemini() async {
    String result = await JudgeFood().judge(
      widget.imgPath,
    ); // result = '食べ物か,信頼度,料理名';
    print('Gemini結果：$result');
    if (result == 'Gemini返答失敗' || result == 'Geminiエラー'){
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'CapturePage'),
      body:
          geminiSuccess
              ? SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Gap(10),
                      isFood == null
                          ? CircularProgressIndicator()
                          : isFood == true
                          ? Text("画像を確認して下さい")
                          : Text("食べ物を撮影して下さい"),
                      Divider(),
                      SizedBox(
                        height: 320,
                        child:
                            fileExists == null
                                ? const Center(
                                  child: CircularProgressIndicator(),
                                ) // ローディング中
                                : fileExists == true
                                ? Image.file(
                                  File(widget.imgPath),
                                ) // ファイルが存在する場合
                                : const Center(
                                  child: Text("データが存在しません"),
                                ), // ファイルが存在しない場合
                      ),
                      Gap(20),
                      fileExists == true
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                  ),
                                  child: Text(
                                    '撮り直す',
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                ),
                                isFood == true
                                    ? TextButton(
                                      onPressed: () {
                                        context.push(
                                          '/mealForm?imgPath=${widget.imgPath}&foodName=$foodName',
                                        );
                                      },
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
                            onPressed: () => context.go('/homePage'),
                            child: Text('HomePageへ'),
                          ),
                      Gap(10),
                    ],
                  ),
                ),
              )
              : Center(
                child: Column(
                  children: [
                    Text('エラーが発生しました', style: TextStyle(color: Colors.red)),
                    TextButton(
                      onPressed: () => context.go('/homePage'),
                      child: Text('HomePageへ'),
                    ),
                  ],
                ),
              ),
    );
  }
}
