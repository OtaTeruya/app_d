import 'package:app_d/capturePage/components/image_with_rotation.dart';
import 'package:app_d/historyPage/view/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PopupUI extends StatelessWidget {
  final PopupUIState uiState;
  final PopupCallback callback;
  const PopupUI({super.key, required this.uiState, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black54, // 半透明の黒
          ),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                      onPressed: callback.closePopup,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: SizedBox(
                        width: 32,
                        height: 32,
                        child: Image.asset('images/icon_close.png'),
                      ),
                    ),
                  ],
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                      uiState.foodName,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center
                  ),
                ),
                Gap(8),
                SizedBox(
                  height: 320,
                  child: ImageWithRotation(
                    imgPath: uiState.imgPath,
                    rotationAngle: uiState.rotationAngle,
                    rotateImage: callback.rotateImage,
                    deleteImage: callback.deleteImage,
                  ),
                ),
              ],
            )
          ),
        ),
      ],
    );
  }
}

class PopupUIState {
  final String foodName;
  final String imgPath;
  final int rotationAngle;

  PopupUIState({
    required this.foodName,
    required this.imgPath,
    required this.rotationAngle,
  });
}