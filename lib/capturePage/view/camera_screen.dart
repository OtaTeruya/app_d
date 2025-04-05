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
    // 画面の向きを取得
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('食事の撮影'),
        leading: BackButton(
          onPressed: () {
            context.go('/homePage');
          },
        ),
      ),
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
      floatingActionButtonLocation:
          isLandscape
              ? RightCenterFloatingActionButtonLocation() // 横向きの場合は右中央
              : FloatingActionButtonLocation.centerDocked, // 縦向きの場合は中央下部
      floatingActionButton: Padding(
        padding:
            isLandscape
                ? const EdgeInsets.only(bottom: 0)
                : const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () async {
              // 写真を撮る
              final image = await _controller.takePicture();
              // path を出力
              print("撮影：${image.path}");
              context.replace('/captureResult?imgPath=${image.path}');
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

/// カスタム FloatingActionButtonLocation
class RightCenterFloatingActionButtonLocation
    extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX =
        scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width -
        16; // 右端から16pxの余白
    final double fabY =
        (scaffoldGeometry.scaffoldSize.height -
            scaffoldGeometry.floatingActionButtonSize.height) /
        2; // 垂直方向の中央
    return Offset(fabX, fabY);
  }
}
