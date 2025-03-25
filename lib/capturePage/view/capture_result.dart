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
              child: Expanded(child: Image.file(File(imgPath))),
            ),
            Gap(20),
            TextButton(
              onPressed: () {
                print(File(imgPath).exists());
                File(imgPath).delete();
                context.go('/capturePage/captureResult?imgPath=$imgPath');
                //context.replace('/capturePage');
              },
              child: Text('撮り直す'),
            ),
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
