import 'dart:io';

import 'package:app_d/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CaptureResult extends StatelessWidget {
  const CaptureResult({super.key, required this.imgPath});
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    print(imgPath);
    return Scaffold(
      appBar: CustomAppBar(title: 'CapturePage'),
      body: Center(
        child: Column(
          children: [
            Gap(10),
            SizedBox(
              height: 320,
              child: FutureBuilder<bool>(
                future: File(imgPath).exists(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Text("エラーが発生しました");
                  } else if (snapshot.data == true) {
                    return Image.file(File(imgPath));
                  } else {
                    return const Text("データが存在しません");
                  }
                },
              ),
            ),
            Gap(20),
            TextButton(
              onPressed: () {
                File(imgPath).delete();
                print("ファイル削除：$imgPath");
                context.replace('/capturePage');
              },
              child: Text('撮り直す'),
            ),
            TextButton(onPressed: () {}, child: Text('保存する')),
            TextButton(
              onPressed: () => context.go('/homePage'),
              child: Text('HomePageへ'),
            ),
            TextButton(
              onPressed: () => context.go('/historyPage'),
              child: Text('HistoryPageへ'),
            ),
          ],
        ),
      ),
    );
  }
}
