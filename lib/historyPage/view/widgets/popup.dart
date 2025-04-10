import 'package:app_d/historyPage/view/history_page.dart';
import 'package:app_d/historyPage/view/widgets/popup_ui.dart';
import 'package:flutter/cupertino.dart';

class Popup extends StatefulWidget {
  final String foodName;
  final String imgPath;
  final HistoryPageCallback callback;
  const Popup({super.key, required this.foodName, required this.imgPath, required this.callback});

  @override
  State<Popup> createState() => _Popup();
}

class _Popup extends State<Popup> implements PopupCallback {
  int rotationAngle = 0;

  @override
  void rotateImage() {
    setState(() {
      rotationAngle = rotationAngle + 90;
    });
  }

  @override
  Future<void> deleteImage() async {
    widget.callback.deleteImageOnPopup();
  }

  @override
  Future<void> closePopup() async {
    await widget.callback.closePopup(rotationAngle);
  }

  @override
  Widget build(BuildContext context) {
    return PopupUI(
        uiState: PopupUIState(
          foodName: widget.foodName,
            imgPath: widget.imgPath,
            rotationAngle: rotationAngle,
        ),
        callback: this
    );
  }
}

abstract class PopupCallback {
  void rotateImage();
  Future<void> deleteImage();
  Future<void> closePopup();
}