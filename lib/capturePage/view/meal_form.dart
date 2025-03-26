import 'dart:io';

import 'package:app_d/custom_app_bar.dart';
import 'package:app_d/data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MealForm extends StatefulWidget {
  const MealForm({super.key, required this.imgPath});
  final String imgPath;

  @override
  State<MealForm> createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  bool? fileExists; // ファイルの存在状態を保持する変数
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _checkFileExists(); // ファイルの存在を確認
  }

  Future<void> _checkFileExists() async {
    final exists = await File(widget.imgPath).exists();
    setState(() {
      fileExists = exists; // 結果を State に保存
    });
  }

  int getDateInt(){
    return now.year * 10000 + now.month * 100 + now.day;
  }
  int getTimeInt(){
    return now.hour * 10000 + now.minute * 100 + now.second;
  }

  void addData() {
    // データを保存する処理
    
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
              SizedBox(
                height: 320,
                child:
                    fileExists == null
                        ? const Center(
                          child: CircularProgressIndicator(),
                        ) // ローディング中
                        : fileExists == true
                        ? Image.file(File(widget.imgPath)) // ファイルが存在する場合
                        : const Center(child: Text("データが存在しません")), // ファイルが存在しない場合
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      addData();
                      context.go('/homePage');
                    },
                    child: Text('HomePageへ'),
                  ),
                  TextButton(
                    onPressed: () {
                      addData();
                      context.go('/historyPage');
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
}
