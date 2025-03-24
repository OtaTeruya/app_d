import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// 写真撮影画面
class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  CameraScreenState createState() =>CameraScreenState();
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
    print("破棄");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // プレビュー画面を表示
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("起動完了");
          return CameraPreview(_controller);
        }else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('エラーが発生しました\n${snapshot.error}'));
        } 
        else {
          print("起動中");
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
