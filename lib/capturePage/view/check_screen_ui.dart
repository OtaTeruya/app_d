import 'package:app_d/capturePage/components/image_with_rotation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'check_screen.dart';

class CheckScreenUI extends StatelessWidget {
  final CheckScreenCallback callback;
  final CheckScreenUIState uiState;

  const CheckScreenUI({
    super.key,
    required this.uiState,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: uiState.geminiSuccess ? _geminiAnswer(uiState, context) : Center(
        //geminiが正しい返答を返さなかった場合
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                AppLocalizations.of(context)!.error_try_again,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: callback.recapture,
              child: Text(AppLocalizations.of(context)!.retake),
            ),
          ],
        ),
      ),
    );
  }

  Widget _geminiAnswer(CheckScreenUIState uiState, BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Gap(10),
            uiState.isFood == null
                ? CircularProgressIndicator()
                : uiState.isFood == true
                ? Text(AppLocalizations.of(context)!.please_check_the_image)
                : Text(AppLocalizations.of(context)!.please_take_a_photo_of_food),
            Divider(),
            SizedBox(
              height: 320,
              child:
              uiState.fileExists == null
                  ? const Center(child: CircularProgressIndicator(),) // ローディング中
                  : uiState.fileExists == true
                    ? ImageWithRotation(
                    imgPath: uiState.imgPath,
                    rotationAngle: uiState.rotationAngle,
                    rotateImage: callback.rotateImage,
                    deleteImage: null)
                    : Center(child: Text(AppLocalizations.of(context)!.no_data_available),),
            ),
            Gap(20),
            uiState.fileExists == true
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: callback.recapture,
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Colors.blue),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.retake,
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  uiState.isFood == true
                      ? TextButton(
                    onPressed: () {callback.moveToResultScreen();},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.ok,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                      : SizedBox(),
                ],
              ),
            )
                : TextButton(
              onPressed: callback.recapture,
              child: Text(AppLocalizations.of(context)!.retake),
            ),
            Gap(10),
          ],
        ),
      ),
    );
  }
}

class CheckScreenUIState {
  String imgPath;
  bool? fileExists;
  int rotationAngle;
  bool? isFood;
  String foodName;
  bool geminiSuccess;

  CheckScreenUIState({
    required this.imgPath,
    required this.fileExists,
    required this.rotationAngle,
    required this.isFood,
    required this.foodName,
    required this.geminiSuccess,
  });
}