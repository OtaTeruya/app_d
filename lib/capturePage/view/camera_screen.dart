import 'package:app_d/custom_app_bar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 写真撮影画面
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      // カメラを指定
      widget.camera,
      // 解像度を定義
      ResolutionPreset.medium,
      // マイクへのアクセスをしない
      enableAudio: false,
    );

    // コントローラーを初期化
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // ウィジェットが破棄されたら、コントローラーを破棄
    print("カメラ破棄");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // プレビュー画面を表示
    return Scaffold(
      appBar: CustomAppBar(title: 'CapturePage'),
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("カメラ起動完了");
              return CameraPreview(_controller);
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('エラーが発生しました\n${snapshot.error}'));
            } else {
              print("カメラ起動中");
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      //撮影のボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () async {
              // 写真を撮る
              final image = await _controller.takePicture();
              // path を出力
              print(image.path);
              context.replace('/capturePage/captureResult?imgPath=${image.path}');
            },
            backgroundColor: Colors.white,
            shape: CircleBorder(),
            child: const Icon(Icons.camera, color: Colors.black, size: 50),
          ),
        ),
      ),
    );
  }
}
