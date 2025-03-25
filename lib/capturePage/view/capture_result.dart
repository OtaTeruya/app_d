import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    print(widget.imgPath);
    return Scaffold(
      appBar: CustomAppBar(title: 'CapturePage'),
      body: Center(
        child: Column(
          children: [
            Gap(10),
            SizedBox(
              height: 320,
              child: FutureBuilder<bool>(
                future: File(widget.imgPath).exists(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: const Text("エラーが発生しました"));
                  } else if (snapshot.data == true) {
                    return Image.file(File(widget.imgPath));
                  } else {
                    return Center(child: const Text("データが存在しません"));
                  }
                },
              ),
            ),
            Gap(20),
            Padding(
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
                    child: Text('撮り直す',style: TextStyle(color: Colors.blueGrey),),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/capturePage/captureResult/mealForm?imgPath=${widget.imgPath}');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: Text('これにする！', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
